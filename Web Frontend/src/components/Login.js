import React, { useEffect, useState } from "react";
import StateLoginForm from "./Login Form/StateLoginForm";
import styled from "styled-components";
import ashokStambh from "./logo.png";
import { useMediaQuery } from "react-responsive";
import ResponsivePage from "../components/ResponsivePage";

import AdminLoginForm from "./Login Form/AdminLoginForm";
// import AdminLoginForm2 from "./Login Form/AdminLoginForm2";
import DistrictLoginForm from "./Login Form/DistrictLoginForm";
import BlockLoginForm from "./Login Form/BlockLoginForm";
import NavbarOfLandingPage from "./landingPage/NavbarOfLandingPage";
import Footer from "./Footer";

const Login = () => {
  const isTabletOrMobile = useMediaQuery({ query: "(max-width: 1224px)" });

  const [login, setLogin] = useState("login-as");

  const [superAdmin, setSuperAdmin] = useState(false);
  // const [superAdmin2, setSuperAdmin2] = useState(false);
  const [stateAdmin, setStateAdmin] = useState(false);
  const [districtAdmin, setDistrictAdmin] = useState(false);
  const [blockAdmin, setBlockAdmin] = useState(false);

  useEffect(() => {
    login === "super-admin" ? setSuperAdmin(true) : setSuperAdmin(false);
    // login === "super-admin2" ? setSuperAdmin2(true) : setSuperAdmin2(false);
    login === "state-admin" ? setStateAdmin(true) : setStateAdmin(false);
    login === "disrict-admin"
      ? setDistrictAdmin(true)
      : setDistrictAdmin(false);
    login === "block-admin" ? setBlockAdmin(true) : setBlockAdmin(false);
  }, [login]);

  const handleOnChange = (e) => {
    setLogin(e.target.value);
  };
  return (
    <>
      {isTabletOrMobile && <ResponsivePage />}
      <NavbarOfLandingPage />
      <Container>
        <Left>
          <Image src={ashokStambh}></Image>
        </Left>
        <Right>
          <RightDivCenter>
            <h1>Assest Sync</h1>
            <Wrap>
              <h2>Login As</h2>
              <select
                className="form-select"
                value={login}
                onChange={handleOnChange}
              >
                <option value="login-as">Login As</option>
                <option value="super-admin">Super Admin</option>
                {/* <option value="super-admin2">Super Admin 2</option> */}
                <option value="state-admin">State Admin</option>
                <option value="disrict-admin">District Admin</option>
                <option value="block-admin">Block Admin</option>
              </select>
            </Wrap>
            <Wrap2>
              {superAdmin && <AdminLoginForm />}
              {/* {superAdmin2 && <AdminLoginForm2 />} */}
              {stateAdmin && <StateLoginForm />}
              {districtAdmin && <DistrictLoginForm />}
              {blockAdmin && <BlockLoginForm />}
            </Wrap2>
          </RightDivCenter>
        </Right>
      </Container>
      <Footer />
    </>
  );
};

export default Login;

const Container = styled.div`
  background-color: #dfffe0;
  width: 100vw;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  // flex-direction: column;
  // border: 1px solid blue;
  // position: relative;
  h1 {
    position: relative;
    bottom: 150px;
    text-align: center;
  }
  @media (max-width: 768px) {
    flex-direction: column;
    width: 100vw;
  }
`;
const Left = styled.div`
  // border: 1px solid black;
  width: 50%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  @media (max-width: 768px) {
    width: 100%;
  }
`;
const Image = styled.img`
  // border: 1px solid black;
  height: 500px;
  @media (max-width: 768px) {
    height: 200px;
  }
`;
const Right = styled.div`
  // border: 1px solid black;
  width: 50%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  // flex-direction: column;
  @media (max-width: 768px) {
    width: 100%;
  }
`;
const RightDivCenter = styled.div`
  // border: 1px solid black;
  box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
  border-radius: 20px;
  padding: 40px;
  background-color: white;
  h1 {
    // border: 1px solid black;
    margin-top: 50px;
    color: #4ba94f;
  }
  @media (max-width: 768px) {
    padding: 1px;
  }
`;
const Wrap = styled.div`
  position: relative;
  bottom: 40px;
  // border: 1px solid black;

  h2 {
    text-align: center;
    position: relative;
    bottom: 30px;
    font-size: 32px;
    color: #4ba94f;
  }
  select {
    padding: 10px;
    width: 400px;
    position: relative;
    bottom: 10px;
  }
`;

const Wrap2 = styled.div`
  // position: absolute;
  // top: 300px;
  // border: 1px solid black;
`;
