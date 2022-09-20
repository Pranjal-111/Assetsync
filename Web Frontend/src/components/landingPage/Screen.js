import React from "react";
import styled from "styled-components";
import Footer from "../Footer";
import bgImage from "./bgImage.png";

const Screen = () => {
  return (
    <>
      <Scr>
        <Upper>
          <Text>
            Welcome To <span> Asset Sync</span>
          </Text>
        </Upper>
        <Down>
          <Image src={bgImage}></Image>
        </Down>
      </Scr>
      <Footer />
    </>
  );
};

export default Screen;

const Scr = styled.div`
  width: 100vw;
  overflow-y: auto;
  height: 83.5vh;
  // border: 1px solid black;
  display: flex;
  background-color: #dfffe0;
  align-items: center;
  justify-content: center;
  flex-direction: column;
`;

const Upper = styled.div`
  // border: 1px solid black;
  background-color: #dfffe0;
  width: 100%;
  height: 30%;
  display: flex;
  align-items: center;
  justify-content: center;
`;
const Text = styled.div`
  // border: 1px solid black;
  width: 60%;
  height: 50%;
  color: #4ba94f;
  font-size: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  // flex-direction: column;
  font-weight: 00;
  span {
    font-size: 70px;
    margin-left: 15px;
    font-weight: 500;
    color: #4ba94f;
  }
  @media (max-width: 768px) {
    font-size: 40px;
    span {
      font-size: 55px;
    }
  }
`;
const Down = styled.div`
  // border: 1px solid black;
  width: 100%;
  background-color: #dfffe0;
  height: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
`;
const Image = styled.img`
  // border: 1px solid black;
  height: 300px;
  @media (max-width: 768px) {
    width: 350px;
    height: 200px;
  }
`;
