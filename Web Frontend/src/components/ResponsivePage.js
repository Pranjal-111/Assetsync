import React from "react";
import styled from "styled-components";

const ResponsivePage = () => {
  return (
    <>
      <Wrapper>
        <h2>Thanks for visiting our website</h2>
        <p>Kindly, download our Mobile App, its support Android</p>
      </Wrapper>
    </>
  );
};

export default ResponsivePage;

const Wrapper = styled.div`
  //   border: 1px solid black;
  width: 100vw;
  height: 100vh;
  background: #dfffe0;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  h2 {
    color: #4ba94f;
  }
  p {
    width: 50%;
    color: #4ba94f;
  }
  &::-webkit-scrollbar {
    display: none;
  }
`;
