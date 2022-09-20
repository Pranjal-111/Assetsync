import React, { useRef, useEffect, useState } from "react";
import mapboxgl from "!mapbox-gl"; // eslint-disable-line import/no-webpack-loader-syntax
import styled from "styled-components";


mapboxgl.accessToken =
  "pk.eyJ1IjoicHJhbmphbGFnZ2Fyd2FsMTIzIiwiYSI6ImNsNWtrbnloOTBhdHozZG14Z2FqZ3NwaTYifQ.zQhR8rdg58WxTlppTiENcQ";
var options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0,
};


function errors(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}



export default function SetMap(props) {
  
  const mapContainer = useRef(null);
  const map = useRef(null);
  const [lng, setLng] = useState(false);
  const [lat, setLat] = useState(false);
  const [zoom, setZoom] = useState(3);
 
  


  function success(pos) {
    
    setLng(pos.coords.longitude);
    setLat(pos.coords.latitude);
  }

  useEffect(() => {
    if (lng && lat && map.current) {
      console.log("Center Map");
      map.current.flyTo({
        center: [lng, lat],
        essential: true, // this animation is considered essential with respect to prefers-reduced-motion
      });

      // Create a new marker.
      const marker = new mapboxgl.Marker({
        draggable: true,
        color: "red",
      })
        .setLngLat([lng, lat])
        .addTo(map.current);

      marker.on("drag", (e) => {
        console.log(marker.getLngLat());
      var t = marker.getLngLat();
        console.log(t);
        console.log(t.lng);
        console.log(t.lat);
      
        props.fetchCordinate(t.lng,t.lat);
     
      });
      
    }
  }, [lng, lat]);




  useEffect(() => {
    if (map.current) return; // initialize map only once
    map.current = new mapboxgl.Map({
      container: mapContainer.current,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [lng, lat],
      zoom: zoom,
    });
  }, [lng, lat]);

  useEffect(() => {
    if (navigator.geolocation) {
      navigator.permissions
        .query({ name: "geolocation" })
        .then(function (result) {
          if (result.state === "granted") {
            console.log(result.state);
            //If granted then you can directly call your function here
            navigator.geolocation.getCurrentPosition(success);
          } else if (result.state === "prompt") {
            navigator.geolocation.getCurrentPosition(success, errors, options);
          } else if (result.state === "denied") {
            //If denied then you have to show instructions to enable location
          }
          result.onchange = function () {
            console.log(result.state);
          };
        });
    } else {
      alert("Sorry Not available!");
    }
  }, []);

  return (
    <div>
      <Map ref={mapContainer} className="map-container" />
    </div>
  );
}
const Map = styled.div`
  width: 50vw;
  height: 50vh;
`;


