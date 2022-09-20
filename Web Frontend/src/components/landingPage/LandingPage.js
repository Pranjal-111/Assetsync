import React from "react";
import NavbarOfLandingPage from "./NavbarOfLandingPage";
import Screen from "./Screen";
import { useMediaQuery } from "react-responsive";
import ResponsivePage from "../ResponsivePage";

const LandingPage = () => {
  const isTabletOrMobile = useMediaQuery({ query: "(max-width: 1224px)" });
  return (
    <>
      {isTabletOrMobile && <ResponsivePage />}
      <NavbarOfLandingPage />
      <Screen />
    </>
  );
};

export default LandingPage;
