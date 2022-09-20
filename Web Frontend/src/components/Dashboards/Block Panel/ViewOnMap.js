import React, { useRef, useEffect, useState } from "react";
import styled from "styled-components";
import mapboxgl from "!mapbox-gl"; // eslint-disable-line import/no-webpack-loader-syntax

mapboxgl.accessToken =
  "pk.eyJ1IjoicHJhbmphbGFnZ2Fyd2FsMTIzIiwiYSI6ImNsNWtrbnloOTBhdHozZG14Z2FqZ3NwaTYifQ.zQhR8rdg58WxTlppTiENcQ";

const ViewOnMap = () => {
  const mapContainer = useRef(null);
  const map = useRef(null);

  const [lng, setLng] = useState(false);
  const [lat, setLat] = useState(false);
  const [zoom, setZoom] = useState(15);

  const fetchCordinate = () => {
    let search = window.location.search;
    const urlParams = new URLSearchParams(search);
    const lang = urlParams.get("long");
    const lati = urlParams.get("lat");
    setLng(lang);
    setLat(lati);
  };

  useEffect(() => {
    fetchCordinate();
  }, []);

  useEffect(() => {
    if (!map.current) {
      map.current = new mapboxgl.Map({
        container: mapContainer.current,
        style: "mapbox://styles/mapbox/streets-v11",
        center: [lng, lat],
        zoom: zoom,
      });
      map.current.on("click", (e) => {
        console.log(`A click event has occurred at ${e.lngLat}`);
      });
    }

    if (lng && lat && map.current) {
      console.log(lng, lat);
      map.current.flyTo({
        center: [lng, lat],
        essential: true, // this animation is considered essential with respect to prefers-reduced-motion
      });

      // Create a new marker.
      const marker = new mapboxgl.Marker({
        color: "red",
      })
        .setLngLat([lng, lat])
        .addTo(map.current);
    }
  }, [lng, lat]);

  return (
    <div>
      <Map ref={mapContainer} className="map-container" />
    </div>
  );
};

export default ViewOnMap;

const Map = styled.div`
  width: 100vw;
  height: 100vh;
`;
