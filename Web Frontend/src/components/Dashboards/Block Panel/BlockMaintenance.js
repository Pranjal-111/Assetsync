import React, { useEffect, useState } from "react";
import styled from "styled-components";
import NavbarOfBlock from "./NavbarOfBlock";
import Footer from "../../Footer";
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

const BlockMaintenance = () => {
  const [asset_id, setId] = useState();
  console.log(asset_id);



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
  const [type, setType] = useState();
  const [requirement, setRequirement] = useState();
  const [budget, setBudget] = useState();
  const[proposal,setUrl] = useState();

  let item = {
    asset_id,requirement,budget,proposal,type
      };
  console.log(item);

  async function PostData() {
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/subblock/maintanance", // edit wali api lgani h
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
        <Heading>Maintenance</Heading>
        <form method="POST">
          <Cont>
            <label>
              Maintenance Type
              <select
                className="form-select"
                // value={login}
                onChange={(e) => setType(e.target.value)}
              >
                <option value="Asset-Type">Asset Type</option>
                <option value="repairment">Repairment</option>
                <option value="construction">Construction</option>
              </select>
            </label>

            <label>
              Asset Requirement:
              {/* <input
                type="text-area"
                onChange={(e) => setRequirement(e.target.value)}
                placeholder="Enter Asset Requirement"
              /> */}
              <textarea
                rows="5"
                cols="50"
                onChange={(e) => setRequirement(e.target.value)}
                placeholder="Enter your requirement"
              ></textarea>
            </label>
            <label>
              Asset Budget:
              <input
                type="number"
                onChange={(e) => setBudget(e.target.value)}
                placeholder="Enter Asset Budget"
              />
            </label>

            <label>
              Upload Files
              {/* <input
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
              /> */}
            </label>
            <label>
              Select the Proposal
              <input
                type="file"
                multiple
                onChange={(e) => {
                  const storage = getStorage();

                 
                    const storageRef = ref(
                      storage,
                      "proposal_images/" + e.target.files.name
                    );

                    const uploadTask = uploadBytesResumable(
                      storageRef,
                      e.target.files
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
                            setUrl(downloadURL);
                            console.log("File available at", downloadURL);
                          }
                        );
                      }
                    );
                  
                }}
              />
            </label>

            <input type="button" value="Submit" onClick={PostData} />
          </Cont>
        </form>
      </Container>
      <Footer />
    </>
  );
};

export default BlockMaintenance;

const Container = styled.div`
  width: 100vw;
  height: 177vh;
  border: 1px solid black;
  overflow-y: auto;
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
  height: 80%;
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
