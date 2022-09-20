import React, { useState, useEffect } from "react";
import styled from "styled-components";
import Footer from "../../Footer";
import NavbarOfDistrict from "../District Panel/NavbarOfDistrict";

const DistrictAdministration = () => {
  const [name, setName] = useState();
  const [phone, setNumber] = useState();
  const [email, setEmail] = useState();
  const [data, getData] = useState([]);

  // GET API
  const GET_API_URL = "https://assetasync.herokuapp.com/api/city/getsubblock";
  useEffect(() => {
    fetchData();
  }, []);

  // const fetchData = () => {
  //   fetch(GET_API_URL)
  //     .then((response) => response.json())
  //     .then((response) => {
  //       console.log(response);
  //       getData(response.data);
  //     });
  // };

  async function fetchData() {
    // console.warn(username, password);
    var data = localStorage.getItem("user-info");
    var dataa = JSON.parse(data);
    var state_id = dataa.state_id;
    var district_id = dataa.id;

    let item = { district_id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/city/getsubblock",
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
    getData(result.data);
  }

  async function PostData() {
    // console.warn(username, password);
    var data = localStorage.getItem("user-info");
    var dataa = JSON.parse(data);
    var state_id = dataa.state_id;
    var district_id = dataa.id;

    let item = { name, phone, email, state_id, district_id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/city/createDistrictBlocks",
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
  }

  return (
    <>
      <NavbarOfDistrict />
      <Container>
        <Heading>Add User</Heading>

        <FormContainer method="POST">
          <Input>
            <label>
              User Name:
              <input
                type="text"
                onChange={(e) => setName(e.target.value)}
                placeholder="Enter Your Name"
              />
            </label>
          </Input>
          <Input>
            <label>
              Phone Number:
              <input
                type="number"
                onInput={(e) => {
                  if (e.target.value.length > e.target.maxLength)
                    e.target.value = e.target.value.slice(
                      0,
                      e.target.maxLength
                    );
                }}
                maxlength={10}
                onChange={(e) => setNumber(e.target.value)}
                placeholder="Enter Your Phone Number"
              />
            </label>
          </Input>
          <Input>
            <label>
              Email:
              <input
                type="email"
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Enter Your Email"
              />
            </label>
          </Input>
          <ButtonCenter>
            <Button>
              <input type="button" value="Add User" onClick={PostData} />
            </Button>
          </ButtonCenter>
        </FormContainer>
        <TableContainer>
          <UserHeading>User Details</UserHeading>
          <ScrollBar>
            <Table>
              <thead>
                <tr>
                  <th>Sr.No.</th>
                  <th>User Name</th>
                  <th>Phone No.</th>
                  <th>Email Address</th>
                </tr>
              </thead>
              <tbody>
                {data.map((item, i) => {
                  return (
                    <tr key={i}>
                      <td>{i + 1}</td>
                      <td>{item.name}</td>
                      <td>{item.phone}</td>
                      <td>{item.email}</td>
                    </tr>
                  );
                })}
              </tbody>
            </Table>
          </ScrollBar>
        </TableContainer>
      </Container>
      <Footer />
    </>
  );
};

export default DistrictAdministration;

const Container = styled.div`
  width: 100vw;
  height: 100vh;
  // border: 1px solid blue;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  flex-direction: column;
  background-color: #dfffe0;
`;
const Heading = styled.div`
  // border: 1px solid black;
  font-size: 40px;
  font-weight: 500;
  color: #4ba94f;
  margin-top: 18px;
`;
const FormContainer = styled.form`
  // border: 1px solid black;
  height: 18%;
  width: 90%;
  margin-top: 2%;
  margin-bottom: 3%;
  display: flex;
  justify-content: space-evenly;
  box-shadow: rgba(99, 99, 99, 0.2) 0px 4px 8px 0px;
  align-items: center;
  background-color: white;
  border-radius: 30px;
  @media (max-width: 800px) {
    flex-direction: column;
    height: 75%;
    width: 50%;
  }
  @media (max-width: 500px) {
    width: 80%;
  }
`;
const Input = styled.div`
  // border: 1px solid black;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  // width: 20%;
  label {
    font-weight: 600;
    color: #4ba94f;
  }
  input {
    margin: 5px;
    padding: 8px;
    width: 300px;
    // width: 100%;
    border: 2px solid #4ba94f;
    &:focus {
      color: #4ba94f;
    }
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    @media (max-width: 1300px) {
      width: 200px;
    }
    @media (max-width: 1000px) {
      width: 150px;
    }
    @media (max-width: 800px) {
      width: 300px;
    }
    @media (max-width: 700px) {
      width: 200px;
    }
    @media (max-width: 500px) {
      width: 250px;
    }
    @media (max-width: 350px) {
      width: 200px;
    }
  }
`;
const ButtonCenter = styled.div`
  // border: 1px solid black;
`;
const Button = styled.div`
  input[type="button"] {
    border-radius: 50px;
    cursor: pointer;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 7px 8px 0px;
    width: 150px;
    border: none;
    font-size: 18px;
    background-color: #4ba94f;
    color: white;
    padding: 10px;
  }
`;

const TableContainer = styled.div`
  // border: 1px solid black;
  width: 100%;
  height: 60%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
`;
const UserHeading = styled.div`
  // border: 1px solid black;
  font-size: 35px;
  font-weight: 500;
  color: #4ba94f;
  padding-bottom: 10px;
`;
const ScrollBar = styled.div`
  overflow-y: auto;
  border-collapse: collapse;
  width: 75%;
  // border: 1px solid black;
  height: 70%;
  &::-webkit-scrollbar {
    // -webkit-appearance: none;
    width: 10px;
    height: 12px;
    // border: 1px solid black;
  }
  &::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px grey;
    border-radius: 10px;
  }

  /* Handle */
  &::-webkit-scrollbar-thumb {
    background: #4ba94f;
    border-radius: 10px;
  }

  /* Handle on hover */
  &::-webkit-scrollbar-thumb:hover {
    background: grey;
  }
`;
const Table = styled.table`
  // border: 1px solid black;
  // border-radius: 30px;
  // margin-top: 2%;
  // background-color: #4ba94f;
  // width: 75%;
  width: 100%;
  // height: 100%;
  th {
    // border: 1px solid black;
    padding: 15px 25px;
    font-size: 18px;
    background-color: #4ba94f;
    // border-radius: 30px;
    color: white;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 4px 8px 0px;
    position: sticky;
    top: 0px;
  }
  }
  td {
    // border: 1px solid black;
    padding: 7px 42px;
    text-align: center;
    // border-radius: 30px;
    background-color: white;
    box-shadow: rgba(99, 99, 99, 0.2) 0px 4px 8px 0px;
  }
`;
