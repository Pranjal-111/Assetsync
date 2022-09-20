import React, { useState } from "react";
import styled from "styled-components";
import {
  MenuOutlined,
  CloseOutlined,
  MailOutlined,
  PhoneOutlined,
  GlobalOutlined,
} from "@ant-design/icons";
import { Link } from "react-router-dom";
import { Box, Button, Modal, Popover, Typography } from "@mui/material";
// import myImage from "./logo.png";

const NavbarOfLandingPage = () => {
  const [anchorEl, setAnchorEl] = React.useState(null);
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };
  const open = Boolean(anchorEl);
  const id = open ? "simple-popover" : undefined;

  const [burgerStatus, setBurgerStatus] = useState(false);
  return (
    <Container>
      {/* <Image src={myImage}></Image> */}
      <p>Asset-Sync</p>
      <Menu>
        <Div>
          <Link to="/">Home</Link>
          <Link to="/about-us">About Us</Link>
          {/* <Link to="/contact-us">Contact Us</Link> */}
          <div aria-describedby={id} variant="contained" onClick={handleClick}>
            <a>Contact Us</a>
          </div>
          <Popover
            id={id}
            open={open}
            anchorEl={anchorEl}
            onClose={handleClose}
            anchorOrigin={{
              vertical: "bottom",
              horizontal: "left",
            }}
          >
            <Typography sx={{ p: 2 }}>
              <PopUpOutside>
                <Content>
                  <LogoOfMail></LogoOfMail>admin@assetsync.tech
                </Content>
                <Content>
                  <LogoOfPhone></LogoOfPhone>+91 9998887776
                </Content>
                <Content>
                  <LogoOfWeb></LogoOfWeb>www.assetsync.tech
                </Content>
              </PopUpOutside>
            </Typography>
          </Popover>
        </Div>

        <NavLink>
          <Link to="/login">Login</Link>
        </NavLink>
      </Menu>
      <RightMenu>
        <CustomMenu onClick={() => setBurgerStatus(true)} />
      </RightMenu>
      <BurgerNav show={burgerStatus}>
        <CloseWrapper>
          <CustomClose onClick={() => setBurgerStatus(false)} />
        </CloseWrapper>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/about-us">About Us</Link>
        </li>
        {/* <li>
          <Link to="/contact-us">Contact Us</Link>
        </li> */}
        <li>
          <Link to="/login">Login</Link>
        </li>
      </BurgerNav>
    </Container>
  );
};

export default NavbarOfLandingPage;

const Container = styled.div`
  min-height: 60px;
  width: 100vw;
  //   position: fixed;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  top: 0;
  left: 0;
  background: #4ba94f;
  right: 0;
  z-index: 1;
  // border: 1px solid black;
  // color: #65c0ff;
  p {
    font-weight: 600;
    color: white;
    font-size: 18px;
    text-transform: uppercase;
    padding: 0 85px;
    // border: 1px solid black;
  }
  @media (max-width: 768px) {
    p {
      padding: 0 45px;
    }
  }
`;
// const Image = styled.img`
//   border: 1px solid black;
//   width: 30px;
//   height: 40px;
//   // filter: opacity(0.4) drop-shadow(0 0 0 red);
//   filter: opacity(1) drop-shadow(0 0 0 white);
// `;
const Menu = styled.div`
  display: flex;
  align-items: center;

  justify-content: flex-end;
  //   border: 1px solid black;
  flex: 1;

  a {
    font-weight: 600;
    text-transform: uppercase;
    padding: 0 10px;
    flex-wrap: nowrap;
    color: white;
    text-decoration: none;
    padding: 0 30px;
  }
`;
const Div = styled.div`
  // border: 1px solid black;
  display: flex;
  cursor: pointer;
  @media (max-width: 768px) {
    display: none;
  }
`;
const NavLink = styled.div`
  // border: 1px solid white;
  background-color: #dfffe0;
  border-radius: 50px;
  margin-right: 115px;
  padding: 0.5%;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  font-weight: 500;
  a {
    font-size: 16px;
    text-decoration: none;
    underline: none;
    color: #4ba94f;
  }
  @media (max-width: 768px) {
    display: none;
  }
`;

const RightMenu = styled.div`
  display: flex;
  align-items: center;
  cursor: pointer;
  a {
    font-weight: 600;
    text-transform: uppercase;
    margin-right: 10px;
    color: white;
  }
`;
const CustomMenu = styled(MenuOutlined)`
  cursor: pointer;
  // border: 1px solid black;
  padding: 0 80px;
  color: white;
  @media (min-width: 768px) {
    display: none;
  }
`;
const PopUpOutside = styled.div`
  width: 250px;
  height: 150px;
  display: flex;
  flex-direction: column;
  align-items: start;
  justify-content: center;
  // border: 1px solid black;
`;
const Content = styled.div`
  // border: 1px solid black;
  font-size: 20px;
  margin-left: 7px;
  color: #4ba94f;
`;
const LogoOfMail = styled(MailOutlined)`
  margin-right: 12px;
  color: #4ba94f;
`;
const LogoOfPhone = styled(PhoneOutlined)`
  margin-right: 12px;
  color: #4ba94f;
`;
const LogoOfWeb = styled(GlobalOutlined)`
  margin-right: 12px;
  color: #4ba94f;
`;
const BurgerNav = styled.div`
  position: fixed;
  top: 0;
  bottom: 0;
  right: 0;
  background: #dfffe0;
  width: 300px;
  z-index: 16;
  list-style: none;
  padding: 20px;
  display: flex;
  flex-direction: column;
  text-align: start;

  transform: ${(props) => (props.show ? `tranlateX(0)` : `translateX(100%)`)};
  transition: transform 0.2s ease-in-out;

  li {
    padding: 15px 0;
    border-bottom: 1px solid #4ba94f;
  }
  a {
    font-weight: 600;
    text-decoration: none;
    color: black;
  }
`;
const CustomClose = styled(CloseOutlined)`
  cursor: pointer;
`;
const CloseWrapper = styled.div`
  display: flex;
  justify-content: flex-end;
`;
