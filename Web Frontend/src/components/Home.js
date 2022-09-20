import React from "react";
import Navbar from "./Navbar";
import Login from "../components/Login";
import HomeScreen from "./HomeScreen";
// import Login from "../components/Login";
// import HomeScreen from "./HomeScreen";

const Home = () => {
  return (
    <>
      <Navbar />
      {/* <Login /> */}
      <HomeScreen />
    </>
  );
};

export default Home;
