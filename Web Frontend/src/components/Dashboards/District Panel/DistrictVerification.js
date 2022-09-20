import React, { useEffect, useState } from "react";
import styled from "styled-components";
import Footer from "../../Footer";
import "../../../../src/App.css";
import { Link } from "react-router-dom";

import { Popover, Typography } from "@mui/material";
import NavbarOfDistrict from "./NavbarOfDistrict";

const BlockVerification = () => {
  const [data, getData] = useState([]);
  const [isApproved, setIsApproved] = useState(false);

  const Approved = async (isApproved, id) => {
    // console.warn(username, password);

    let item = { isApproved, id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/district/approved",
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
  };

  async function fetchData() {
    // console.warn(username, password);
    var data = localStorage.getItem("user-info");
    var dataa = JSON.parse(data);
    var district_id = dataa.id;

    let item = { district_id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/district/verification",
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

  useEffect(() => {
    fetchData();
  }, []);

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
    <>
      <NavbarOfDistrict />
      <Container>
        <Heading>Verification</Heading>
        <Content>
          <TableContainer>
            <ScrollBar>
              <Table>
                <thead>
                  <tr>
                    <th>Sr.No.</th>
                    <th>Asset Name</th>
                    <th>Asset Type</th>
                    <th>Asset Location</th>
                    <th>Asset Size</th>
                    <th>Asset Capacity</th>
                    <th>Present Use</th>
                    <th>Year of Establishment</th>
                    <th>No. of Rooms</th>
                    <th>No. of Labs</th>
                    <th>Maintained ?</th>
                  </tr>
                </thead>

                <tbody>
                  {data.map((item, i) => {
                    return (
                      <tr key={i}>
                        <td>{i + 1}</td>
                        <td>
                          {item.name && item.name ? item.name : "Not Mentioned"}
                        </td>
                        <td>
                          {item.type && item.type ? item.type : "Not Mentioned"}
                        </td>
                        <td>
                          <Link
                            to={{
                              pathname: `'viewOnMap?long=${item.lon}&lat=${item.lat}`,
                            }}
                          >
                            {item.address && item.address
                              ? item.address
                              : "Not Mentioned"}
                          </Link>
                        </td>
                        <td>
                          {item.size && item.size ? item.size : "Not Mentioned"}
                        </td>
                        <td>
                          {item.capacity && item.capacity
                            ? item.capacity
                            : "Not Mentioned"}
                        </td>
                        <td>
                          {item.present_use && item.present_use
                            ? item.present_use
                            : "Not Mentioned"}
                        </td>
                        <td>
                          {item.yaer_of_est && item.yaer_of_est
                            ? item.yaer_of_est
                            : "Not Mentioned"}
                        </td>
                        <td>
                          {item.rooms && item.rooms
                            ? item.rooms
                            : "Not Mentioned"}
                        </td>
                        <td>
                          {item.labs && item.labs ? item.labs : "Not Mentioned"}
                        </td>
                        <td>
                          {item.maintance && item.maintance
                            ? item.maintance
                            : "Not Mentioned"}
                        </td>
                        <td>
                          <a onClick={() => Approved(true, item.id)}>Accept</a>
                          <br />
                          <a
                            onClick={() => Approved(false, item.id)}
                            style={{ color: "red" }}
                          >
                            Reject
                          </a>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </Table>
            </ScrollBar>
          </TableContainer>
        </Content>
      </Container>
      <Footer />
    </>
  );
};

export default BlockVerification;

const Container = styled.div`
  width: 100vw;
  height: 100vh;
  background-color: #dfffe0;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
  //   border: 1px solid black;
`;

const Heading = styled.div`
  //   border: 1px solid black;
  margin-top: 1%;
  margin-bottom: 1%;
  font-size: 40px;
  color: #4ba94f;
`;
const Content = styled.div`
  display: flex;
  // border: 1px solid black;
  align-items: flex-start;
  justify-content: center;
  height: 100%;
`;
const TableContainer = styled.div`
  //   border: 1px solid black;
  overflow-y: auto;
  width: 80%;
  // position: relative;
  // bottom: 40px;
  height: 60%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
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
const ScrollBar = styled.div`
  overflow-y: auto;
  border-collapse: collapse;
  // box-shadow: rgba(99, 99, 99, 0.2) 0px 4px 8px 0px;
  width: 100%;
  // border: 1px solid black;
  height: 100%;
  ::-webkit-scrollbar {
    // -webkit-appearance: none;
    width: 15px;
    height: 15px;
    // border: 1px solid black;
  }
  &::-webkit-scrollbar {
    // -webkit-appearance: none;
    width: 10px;
    height: 12px;
    // border: 1px solid black;
  }
  &::-webkit-scrollbar-track {
    box-shadow: inset 0 0 5px #4ba94f;
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
  //   border: 1px solid black;
  // border-radius: 30px;
  //   margin-top: 3%;
  // background-color: #4ba94f;
  width: 85%;
  tbody {
    overflow-y: auto;
  }
  th {
    // border: 1px solid black;
    padding: 5px 28px;
    font-size: 16px;
    background-color: #4ba94f;
    // border-radius: 30px;
    color: white;
  }
  td {
    // border: 1px solid black;
    padding: 10px 2px;
    text-align: center;
    // border-radius: 30px;
    background-color: white;
    a {
      color: #4ba94f;
      cursor: pointer;
      &:hover {
        text-decoration: underline;
        font-weight: 700;
      }
    }
  }
`;
