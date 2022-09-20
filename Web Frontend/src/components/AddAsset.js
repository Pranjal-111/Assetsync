import React from "react";
import Navbar from "./Navbar";
import styled from "styled-components";

const AddAsset = () => {
  return (
    <Container>
      <Navbar />
      <AddAdminForm>
        <form>
          <Cont>
            <label>
              Name:
              <input type="text" name="name" placeholder="Enter Your Name" />
            </label>
            <label>
              Name:
              <input type="text" name="name" placeholder="Enter Your Name" />
            </label>
            <label>
              Name:
              <input type="text" name="name" placeholder="Enter Your Name" />
            </label>
            <label>
              Name:
              <input type="text" name="name" placeholder="Enter Your Name" />
            </label>
            <label>
              Name:
              <input type="text" name="name" placeholder="Enter Your Name" />
            </label>
            <label>
              Name:
              <input type="text" name="name" placeholder="Enter Your Name" />
            </label>
            <label>
              Phone Number:
              <input
                type="number"
                name="number"
                placeholder="Enter your Phone Number"
              />
            </label>
            <label>
              Email:
              <input
                type="email"
                name="email-for-credentials"
                placeholder="Email for Credentials"
              />
            </label>
            <label>
              Password:
              <input
                type="password"
                name="password"
                placeholder="Enter Your Password"
              />
            </label>
            <input type="submit" value="Submit" />
          </Cont>
        </form>
      </AddAdminForm>
    </Container>
  );
};

export default AddAsset;

const Container = styled.div`
  border: 1px solid black;
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
`;
const AddAdminForm = styled.div`
  border: 1px solid blue;
`;

const Cont = styled.div`
  display: flex;
  flex-direction: column;

  label {
    display: flex;
    flex-direction: column;
  }
  input {
    margin: 5px;
    padding: 5px;
  }
  input[type="submit"] {
    margin-top: 15px;
    border-radius: 50px;
    background: white;
    cursor: pointer;
  }
`;
