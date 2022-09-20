import React, { useState, useEffect } from "react";
import styled from "styled-components";
import { MenuOutlined, CloseOutlined } from "@ant-design/icons";
import { Link } from "react-router-dom";
import { Box, Button, Modal, Popover, Typography } from "@mui/material";
import { useNavigate } from "react-router-dom";

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 400,
  bgcolor: "background.paper",
  border: "2px solid #000",
  boxShadow: 24,
  p: 4,
};

const NavbarOfAdmin = () => {
  const [burgerStatus, setBurgerStatus] = useState(false);
  const [oldPassword, setOldPassword] = useState();
  const [newPassword, setNewPassword] = useState();
  const [retypeNewPassword, setRetypeNewPassword] = useState();

  const [anchorEl, setAnchorEl] = React.useState(null);
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };
  const open = Boolean(anchorEl);
  const id = open ? "simple-popover" : undefined;

  const history = useNavigate();
  const [logout, setlogout] = useState(false);

  useEffect(() => {
    if (!localStorage.getItem("adminauth")) {
      history("/login");
    }
  }, [logout]);

  const logouthandler = (e) => {
    e.preventDefault();
    localStorage.removeItem("adminauth");
    setlogout(true);
  };

  const [openPopUp, setOpenPopUp] = React.useState(false);
  const handleOpen = () => setOpenPopUp(true);
  const handleClosed = () => setOpenPopUp(false);

  let user = localStorage.getItem("user-info");
  let nameOfUser = JSON.parse(user);

  return (
    <Container>
      <p>Asset Sync</p>
      <Menu>
        <NavLink>
          <Link to="/admin-statistics">Statistics</Link>
        </NavLink>
        <NavLink>
          <Link to="/admin-administration">Administration</Link>
        </NavLink>

        <NavLink
          aria-describedby={id}
          variant="contained"
          onClick={handleClick}
        >
          <a>ACCOUNT</a>
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
          <Link to="/admin-statistics">Statistics</Link>
        </li>
        <li>
          <Link to="/admin-administration">Administration</Link>
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
                <UserName>{nameOfUser.name}</UserName>
                <ChangePassword>
                  <Button onClick={handleOpen}>Change Password ?</Button>
                  <Modal
                    open={openPopUp}
                    onClose={handleClosed}
                    aria-labelledby="modal-modal-title"
                    aria-describedby="modal-modal-description"
                  >
                    <Box sx={style}>
                      <Typography
                        id="modal-modal-title"
                        variant="h6"
                        component="h2"
                        align="center"
                        color="#4ba94f"
                        fontWeight="700"
                        fontSize="30px"
                      >
                        Change Password
                      </Typography>
                      <Division>
                        <label>
                          Old Password
                          <input
                            type="password"
                            onChange={(e) => setOldPassword(e.target.value)}
                            placeholder="Enter Your Old Password"
                          />
                        </label>
                        <label>
                          New Password
                          <input
                            type="password"
                            name="newPassword"
                            onChange={(e) => setNewPassword(e.target.value)}
                            placeholder="Enter Your New Password"
                          />
                        </label>
                        <ButtonOfResetLink>
                          <input type="button" value="Change Password" />
                        </ButtonOfResetLink>
                      </Division>
                    </Box>
                  </Modal>
                </ChangePassword>
                <Logout onClick={logouthandler}>Logout</Logout>
              </PopUpOutside>
            </Typography>
          </Popover>
        </li>
      </BurgerNav>
    </Container>
  );
};

export default NavbarOfAdmin;

const Container = styled.div`
  min-height: 60px;
  // position: fixed;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background-color: #4ba94f;
  padding: 0 20px;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1;
  //   border: 1px solid black;
  p {
    font-weight: 600;
    text-transform: uppercase;
    color: white;
    padding: 0 50px;
    // border: 1px solid black;
  }
`;
const Menu = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  //   border: 1px solid black;
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
  //   border: 1px solid blue;
  padding: 1%;
  display: flex;
  justify-content: center;
  color: white;
  align-items: center;
  cursor: pointer;
  font-weight: 500;
  a {
    font-size: 16px;
    text-decoration: none;
    underline: none;
    color: white;
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
  font-size: 25px;
  margin-left: 6px;
`;
const ChangePassword = styled.div`
  // border: 1px solid black;
  button {
    color: #4ba94f;
  }
`;
const Logout = styled.div`
  // border: 1px solid black;
  border-radius: 20px;
  padding: 3px 13px;
  margin-top: 8px;
  background-color: #4ba94f;
  color: white;
  &: hover {
    cursor: pointer;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 10px 8px 0px;
  }
  box-shadow: rgba(99, 99, 99, 0.2) 0px 4px 8px 0px;
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
  color: white;
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
  background: #dfffe0;
  flex-direction: column;
  text-align: start;

  transform: ${(props) => (props.show ? `tranlateX(0)` : `translateX(100%)`)};
  transition: transform 0.2s ease-in-out;

  li {
    padding: 15px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.2);
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
const Division = styled.div`
  // border: 1px solid black;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  label {
    padding: 5px;
  }
  input {
    margin: 5px;
    padding: 10px;
    width: 365px;
    border: 1px solid black;
  }
`;
const ButtonOfResetLink = styled.div`
  // border: 1px solid black;
  margin-top: 3%;
  input[type="button"] {
    border-radius: 50px;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 7px 8px 0px;
    cursor: pointer;
    width: 385px;
    border: none;
    font-size: 18px;
    background-color: #4ba94f;
    color: white;
  }
`;
