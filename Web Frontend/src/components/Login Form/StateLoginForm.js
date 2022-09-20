import React, { useState, useEffect } from "react";
import styled from "styled-components";
import { useNavigate } from "react-router-dom";
import { Box, Button, Modal, Typography } from "@mui/material";
import VisibilityIcon from "@mui/icons-material/Visibility";

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

const StateLoginForm = () => {
  const history = useNavigate();
  const [username, setName] = useState();
  const [password, setPassword] = useState();

  useEffect(() => {
    if (localStorage.getItem("stateauth")) {
      history("/state");
      var data = localStorage.getItem("user-info");
      var dataa = JSON.parse(data);
      console.log(dataa.id);
    }
  }, []);

  async function PostData() {
    // console.warn(username, password);
    let item = { username, password };
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/state/login",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
        },
        body: JSON.stringify(item),
      }
    );
    result = await result.json();
    console.log(result);
    if (result.success === 1) {
      history("/state");
      localStorage.setItem("stateauth", true);
      localStorage.setItem("user-info", JSON.stringify(result.data));
    }
  }

  const [open, setOpen] = useState(false);
  const handleOpen = () => setOpen(true);
  const handleClose = () => setOpen(false);

  return (
    <Wrapper>
      <form method="POST">
        <Cont>
          <label>
            State Username:
            <input
              type="text"
              onChange={(e) => setName(e.target.value)}
              placeholder="Enter Your Username"
            />
          </label>

          <label>
            Password:
            <input
              type="password"
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Enter Your Password"
            />
          </label>

          <input type="button" value="Log In" onClick={PostData} />

          <DivisionForForgotPassword>
            <Button onClick={handleOpen}>Forgot Password ?</Button>
            <Modal
              open={open}
              onClose={handleClose}
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
                  Forgot Password
                </Typography>
                <Division>
                  <label>
                    Enter Your Email
                    <input
                      type="email"
                      onChange={(e) => setName(e.target.value)}
                      placeholder="Enter Your Email"
                    />
                  </label>
                  <ButtonOfResetLink>
                    <input type="button" value="Reset Password" />
                  </ButtonOfResetLink>
                </Division>
              </Box>
            </Modal>
          </DivisionForForgotPassword>
        </Cont>
      </form>
    </Wrapper>
  );
};

export default StateLoginForm;

const Wrapper = styled.div`
  // border: 1px solid black;
  width: 100%;
  height: 100%;
`;
const Cont = styled.div`
  display: flex;
  flex-direction: column;
  position: relative;
  bottom: 20px;
  width: 100%;

  label {
    display: flex;
    flex-direction: column;
  }
  input {
    margin: 5px;
    padding: 10px;
    width: 365px;
  }
  input[type="button"] {
    margin-top: 25px;
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

const DivisionForForgotPassword = styled.div`
  // border: 1px solid black;
  width: 385px;
  text-align: center;
  cursor: pointer;
  button {
    color: #4ba94f;
  }
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
const Form = styled.form``;
