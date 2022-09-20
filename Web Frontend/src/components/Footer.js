import React from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";

const Footer = () => {
  const d = new Date();
  let year = d.getFullYear();
  return (
    <>
      <Container>
        <Upper>
          <Link to="/">Home</Link>
          <Link to="/about-us">About Us</Link>
          <Link to="/terms-and-conditions">Terms and Conditions</Link>
          <Link to="/privacy-policy">Privacy Policy</Link>
        </Upper>
        <Down>&copy; {year} Asset Sync</Down>
      </Container>
    </>
  );
};

export default Footer;

const Container = styled.div`
  width: 100vw;
  //   border: 1px solid black;
  display: flex;
  position: relative;
  bottom: 0;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  background: #4ba94f;
`;
const Upper = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  a {
    // border: 1px solid black;
    color: white;
    padding: 6px;
    margin: 4px;
    text-decoration: none;
    &: hover {
      background: white;
      color: #4ba94f;
      border-radius: 10px;
      padding: 0 5px;
    }
  }
`;
const Down = styled.div`
  color: white;
`;
