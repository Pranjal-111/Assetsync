import React, { useEffect, useState } from "react";
import styled from "styled-components";
import NavbarOfBlock from "./NavbarOfBlock";
import Footer from "../../Footer";
import AddLocationRoundedIcon from "@material-ui/icons/AddLocationRounded";

import { initializeApp } from "https://www.gstatic.com/firebasejs/9.9.3/firebase-app.js";
import {
  getStorage,
  ref,
  uploadBytesResumable,
  getDownloadURL,
} from "https://www.gstatic.com/firebasejs/9.9.3/firebase-storage.js";

const firebaseConfig = {
  apiKey: "AIzaSyAKVoc-tNZ3DRpROoIxvtIKLPATtMua3rg",
  authDomain: "assetsync-ba61c.firebaseapp.com",
  projectId: "assetsync-ba61c",
  storageBucket: "assetsync-ba61c.appspot.com",
  messagingSenderId: "203623971230",
  appId: "1:203623971230:web:025b67f89d44fd53bc7e8f",
  measurementId: "G-JHZ6J2JNRL",
};
const app = initializeApp(firebaseConfig);

var options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0,
};
function errors(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}
const BlockEditAsset = () => {
  const [id, setId] = useState();
  console.log(id);

  const fetchId = () => {
    let search = window.location.search;
    const urlParams = new URLSearchParams(search);
    const ids = urlParams.get("id");
    console.log(ids);
    setId(ids);
  };
  useEffect(() => {
    fetchId();
  }, []);

  const [name, setName] = useState();
  const [size, setSize] = useState();
  const [capacity, setCapacity] = useState();
  const [present_use, setpresentuse] = useState();
  const [year_of_est, setyear] = useState();
  const [rooms, setrooms] = useState();
  const [labs, setlabs] = useState();
  const [maintance, setmaintance] = useState();
  const [floors, setfloors] = useState();
  const [owner, setowner] = useState();
  const [working_space, setworking] = useState();
  const [vaccant_space, setvacant] = useState();
  const [parking, setParking] = useState();

  

  let item = {
    name,
    size,
    capacity,
    present_use,
    year_of_est,
    rooms,
    labs,
    maintance,
    floors,
    owner,
    working_space,
    vaccant_space,
    parking,
    id
  };
  console.log(item);

  async function PostData() {
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/subblock/edit", // edit wali api lgani h
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
        body: JSON.stringify(item),
      }
    );
    result = await result.json();

    console.log(result);
  }
  return (
    <>
      <NavbarOfBlock />
      <Container>
        <Heading>Edit Asset</Heading>
        <form method="POST">
          <Cont>
            <label>
              Asset Name:
              <input
                type="text"
                onChange={(e) => setName(e.target.value)}
                placeholder="Enter Asset Name"
              />
            </label>

            <label>
              Asset Size:
              <input
                type="text"
                onChange={(e) => setSize(e.target.value)}
                placeholder="Enter Asset Size"
              />
            </label>
            <label>
              Asset Capacity:
              <input
                type="text"
                onChange={(e) => setCapacity(e.target.value)}
                placeholder="Enter Asset Capacity"
              />
            </label>
            <label>
              Present Use:
              <input
                type="text"
                onChange={(e) => setpresentuse(e.target.value)}
                placeholder="Enter Present Use"
              />
            </label>
            <label>
              Year Of Establishment:
              <input
                type="number"
                onChange={(e) => setyear(e.target.value)}
                placeholder="Year Of Establishment"
              />
            </label>
            <label>
              Number Of Rooms:
              <input
                type="number"
                onChange={(e) => setrooms(e.target.value)}
                placeholder="Number Of Rooms"
              />
            </label>
            <label>
              Number Of Laboratory:
              <input
                type="number"
                onChange={(e) => setlabs(e.target.value)}
                placeholder="Number Of Laboratory"
              />
            </label>
            <label>
              Maintenance
              <select
                className="form-select"
                // value={login}
                onChange={(e) => setmaintance(e.target.value)}
              >
                <option value="Maintenance">Maintenance ?</option>
                <option value="1">Yes</option>
                <option value="1">No</option>
              </select>
            </label>

            <label>
              Number Of Floors:
              <input
                type="number"
                onChange={(e) => setfloors(e.target.value)}
                placeholder="Number Of Floors"
              />
            </label>
            <label>
              Enter Asset Owner:
              <input
                type="text"
                onChange={(e) => setowner(e.target.value)}
                placeholder="Enter Asset Owner"
              />
            </label>
            <label>
              Working Space:
              <input
                type="number"
                onChange={(e) => setworking(e.target.value)}
                placeholder="Working Space (in %)"
              />
            </label>
            <label>
              Vacant Space:
              <input
                type="number"
                onChange={(e) => setvacant(e.target.value)}
                placeholder="Vacant Space (in %)"
              />
            </label>
            <label>
              Parking Space
              <select
                className="form-select"
                // value={login}
                onChange={(e) => setParking(e.target.value)}
              >
                <option value="Parking-space">Parking Space</option>
                <option value="1">Yes</option>
                <option value="0">No</option>
              </select>
            </label>

            <label>
              Upload Files
              <input
                type="file"
                multiple
                onChange={(e) => {
                  const storage = getStorage();

                  for (var i in e.target.files) {
                    const storageRef = ref(
                      storage,
                      "assets_images/" + e.target.files[i].name
                    );

                    const uploadTask = uploadBytesResumable(
                      storageRef,
                      e.target.files[i]
                    );

                    uploadTask.on(
                      "state_changed",
                      (snapshot) => {
                        const progress =
                          (snapshot.bytesTransferred / snapshot.totalBytes) *
                          100;
                        console.log("Upload is " + progress + "% done");
                        switch (snapshot.state) {
                          case "paused":
                            console.log("Upload is paused");
                            break;
                          case "running":
                            console.log("Upload is running");
                            break;
                        }
                      },
                      (error) => {
                        // Handle unsuccessful uploads
                      },
                      () => {
                        getDownloadURL(uploadTask.snapshot.ref).then(
                          (downloadURL) => {
                            console.log("File available at", downloadURL);
                          }
                        );
                      }
                    );
                  }
                }}
              />
            </label>

            <input type="button" value="Add Asset" onClick={PostData} />
          </Cont>
        </form>
      </Container>
      <Footer />
    </>
  );
};

export default BlockEditAsset;

const Container = styled.div`
  width: 100vw;
  height: 177vh;
  border: 1px solid black;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
  background-color: #dfffe0;
`;
const Heading = styled.div`
  // border: 1px solid black;
  margin-top: 1%;
  margin-bottom: 1%;
  font-size: 40px;
  color: #4ba94f;
`;
const Cont = styled.div`
  display: flex;
  border: 1px solid black;
  border-radius: 7px;
  padding: 40px;
  flex-direction: column;
  background-color: white;
  // position: relative;
  // bottom: 20px;
  height: 40%;
  overflow-y: auto;
  overflow-x: hidden;
  label {
    display: flex;
    flex-direction: column;
    // border: 1px solid black;
  }
  input {
    border: 1px solid black;
    margin: 5px;
    padding: 10px;
    width: 365px;
  }
  input[type="button"] {
    margin-top: 25px;
    border-radius: 50px;
    cursor: pointer;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 7px 8px 0px;
    width: 385px;
    border: none;
    font-size: 18px;
    background-color: #4ba94f;
    color: white;
  }
  select {
    margin: 5px;
    padding: 10px;
    width: 385px;
  }
  &::-webkit-scrollbar {
    // -webkit-appearance: none;
    width: 10px;
    height: 12px;
    // border: 1px solid black;
  }
  &::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px grey;
    border-radius: 10px;
  }

  /* Handle */
  &::-webkit-scrollbar-thumb {
    background: #4ba94f;
    border-radius: 10px;
  }

  /* Handle on hover */
  &::-webkit-scrollbar-thumb:hover {
    background: grey;
  }
`;
