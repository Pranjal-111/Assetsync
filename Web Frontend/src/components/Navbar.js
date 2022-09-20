import React, { useState } from "react";
import styled from "styled-components";
import { MenuOutlined, CloseOutlined } from "@ant-design/icons";
// import { Button, Popover } from "antd";
import { Link } from "react-router-dom";
import { Popover, Typography } from "@mui/material";

const Navbar = () => {
  const [burgerStatus, setBurgerStatus] = useState(false);

  const [anchorEl, setAnchorEl] = React.useState(null);
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };
  const open = Boolean(anchorEl);
  const id = open ? "simple-popover" : undefined;

  return (
    <Container>
      <p>Asset Sync</p>
      <Menu>
        <NavLink>
          <Link to="/view-on-map">View on Map</Link>
        </NavLink>
        <NavLink>
          <Link to="/statistics">Statistics</Link>
        </NavLink>
        <NavLink>
          <Link to="/administration">Administration</Link>
        </NavLink>

        <NavLink
          aria-describedby={id}
          variant="contained"
          onClick={handleClick}
        >
          ACCOUNT
        </NavLink>
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
              <UserName>Username</UserName>
              <ChangePassword>Change Password</ChangePassword>
              <Logout>Logout</Logout>
            </PopUpOutside>
          </Typography>
        </Popover>
      </Menu>
      <RightMenu>
        <CustomMenu onClick={() => setBurgerStatus(true)} />
      </RightMenu>
      <BurgerNav show={burgerStatus}>
        <CloseWrapper>
          <CustomClose onClick={() => setBurgerStatus(false)} />
        </CloseWrapper>
        <li>
          <Link to="/view-on-map">View on Map</Link>
        </li>
        <li>
          <Link to="/statistics">Statistics</Link>
        </li>
        <li>
          <Link to="/administration">Administration</Link>
        </li>
        <li>
          <Account
            aria-describedby={id}
            variant="contained"
            onClick={handleClick}
          >
            Account
          </Account>
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
                <UserName>Username</UserName>
                <ChangePassword>Change Password</ChangePassword>
                <Logout>Logout</Logout>
              </PopUpOutside>
            </Typography>
          </Popover>
        </li>
      </BurgerNav>
    </Container>
  );
};

export default Navbar;

const Container = styled.div`
  min-height: 60px;
  // position: fixed;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1;
  // border: 1px solid black;
  p {
    font-weight: 600;
    text-transform: uppercase;
    padding: 0 85px;
    // border: 1px solid black;
  }
`;
const Menu = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  // border: 1px solid black;
  flex: 1;

  a {
    font-weight: 600;
    text-transform: uppercase;
    padding: 0 10px;
    flex-wrap: nowrap;
    color: black;
    text-decoration: none;
    padding: 0 30px;
  }

  @media (max-width: 768px) {
    display: none;
  }
`;

const NavLink = styled.div`
  // border: 1px solid blue;
  padding: 1%;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  font-weight: 500;
  a {
    font-size: 16px;
    text-decoration: none;
    underline: none;
    color: black;
  }
`;

const PopUpOutside = styled.div`
  width: 250px;
  height: 150px;
  display: flex;
  flex-direction: column;
  align-items: start;
  justify-content: center;
`;
const UserName = styled.div`
  // border: 1px solid black;
  font-size: 30px;
`;
const ChangePassword = styled.div`
  // border: 1px solid black;
`;
const Logout = styled.div`
  // border: 1px solid black;
`;
const Account = styled.div`
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
`;
const RightMenu = styled.div`
  display: flex;
  align-items: center;
  cursor: pointer;
  a {
    font-weight: 600;
    text-transform: uppercase;
    margin-right: 10px;
    color: black;
  }
`;
const CustomMenu = styled(MenuOutlined)`
  cursor: pointer;
  // border: 1px solid black;
  padding: 0 80px;
`;
const BurgerNav = styled.div`
  position: fixed;
  top: 0;
  bottom: 0;
  right: 0;
  background: white;
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
    border-bottom: 1px solid rgba(0, 0, 0, 0.2);
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
