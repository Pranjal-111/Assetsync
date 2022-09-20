import { CloseOutlined } from "@ant-design/icons";
import React, { useEffect, useState } from "react";
import styled from "styled-components";
import Navbar from "./Navbar";

const AddAdmin = () => {
  const [data, setData] = useState({
    name: "",
    email: "",
    number: "",
  });

  let name, value;
  const handle = (e) => {
    name = e.target.name;
    value = e.target.value;
    setData({ ...data, [name]: value });
    console.log({ ...data, [name]: e.target.value });
  };

  const PostData = async (e) => {
    e.preventDefault();
    const { name, email, number } = data;
    const res = await fetch("http://localhost:3000/admin/", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name,
        email,
        number,
      }),
    });
    // res = await res.json();
    if (res.status === 400 || !data) {
      console.log("Admin not added");
    } else {
      console.log("Admin added successfully");
    }
  };

  return (
    <Container>
      <Navbar />
      <AddAdminForm>
        <form method="POST">
          <Cont>
            <label>
              Name:
              <input
                type="text"
                onChange={handle}
                value={data.name}
                name="name"
                placeholder="Enter Your Name"
              />
            </label>

            <label>
              Email:
              <input
                type="email"
                onChange={handle}
                value={data.email}
                name="email"
                placeholder="Email for Credentials"
              />
            </label>
            <label>
              Phone Number:
              <input
                type="number"
                onChange={handle}
                value={data.number}
                name="number"
                placeholder="Phone Number"
              />
            </label>
            <input type="submit" value="Generate" onClick={PostData} />
          </Cont>
        </form>
      </AddAdminForm>
    </Container>
  );
};

export default AddAdmin;

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
