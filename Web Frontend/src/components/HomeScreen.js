import React from "react";
import styled from "styled-components";
import Card from "./Card";
import Navbar from "./Navbar";

const HomeScreen = () => {
  return (
    <Container>
      <Navbar />
      <Upper>
        <Wrap>
          <Card />
          <Card />
          <Card />
        </Wrap>
      </Upper>
      <Table></Table>
    </Container>
  );
};

export default HomeScreen;

const Container = styled.div`
  //   border: 1px solid black;
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
`;

const Upper = styled.div`
  //   border: 1px solid black;
  width: 100vw;
  height: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
`;
const Wrap = styled.div`
  //   border: 1px solid black;
  width: 100%;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
`;

const Table = styled.div`
  //   border: 1px solid black;
  width: 100vw;
  height: 50%;
`;
