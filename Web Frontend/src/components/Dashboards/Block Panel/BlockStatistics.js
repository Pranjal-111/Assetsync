import React, { useState, useEffect } from "react";
import styled from "styled-components";
import NavbarOfBlock from "./NavbarOfBlock";
import { Popover, Typography } from "@mui/material";
import { Link, Route } from "react-router-dom";
import Footer from "../../Footer";
import PrivacyTipIcon from "@mui/icons-material/PrivacyTip";

const BlockStatistics = () => {
  const [data, getData] = useState([]);

  async function fetchData() {
    // console.warn(username, password);
    var data = localStorage.getItem("user-info");
    var dataa = JSON.parse(data);
    var sub_area_id = dataa.id;

    let item = { sub_area_id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/subblock/getassets",
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
      {/* <Route path="/viewOnMap" element={<ViewOnMap />} /> */}
      <NavbarOfBlock />
      <Container>
        <Heading>Asset Details</Heading>
        <TableContainer>
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
                <th>Additional Details</th>
                <th>Edit</th>
                <th>Maintenance</th>
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
                          pathname: `/viewOnMap?long=${item.lon}&lat=${item.lat}`,
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
                      {item.capacity && item.capacitsy
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
                      {item.rooms && item.rooms ? item.rooms : "Not Mentioned"}
                    </td>
                    <td>
                      {item.labs && item.labs ? item.labs : "Not Mentioned"}
                    </td>
                    <td>
                      {item.maintance && item.maintance
                        ? item.floors
                        : "Not Mentioned"}
                    </td>
                    <td>
                      <a onClick={handleClick}>View More</a>
                    </td>
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
                          <PopUpHeading>Additional Details</PopUpHeading>
                          <Details>
                            <AssetOwner>
                              <Left>No. of Floors</Left>
                              <Right>
                                {item.floors && item.floors
                                  ? item.floors
                                  : "Not Mentioned"}
                              </Right>
                            </AssetOwner>
                            <Year>
                              <Left>Asset Owner</Left>
                              <Right>
                                {item.owner && item.owner
                                  ? item.owner
                                  : "Not Mentioned"}
                              </Right>
                            </Year>
                            <WorkingSpace>
                              <Left>Working Space:</Left>
                              <Right>
                                {item.working_space && item.working_space
                                  ? item.working_space
                                  : "Not Mentioned"}
                              </Right>
                            </WorkingSpace>
                            <VacantSpace>
                              <Left>Vancant Space:</Left>
                              <Right>
                                {item.vacant_spaces && item.vacant_space
                                  ? item.vacant_space
                                  : "Not Mentioned"}
                              </Right>
                            </VacantSpace>
                            <ParkingSpace>
                              <Left>Parking Space:</Left>
                              <Right>
                                {item.parking && item.parking
                                  ? item.parking
                                  : "Not Mentioned"}
                              </Right>
                            </ParkingSpace>
                            <ImageSection>
                              <ImageHeading>Images</ImageHeading>
                              <Images></Images>
                            </ImageSection>
                          </Details>
                        </PopUpOutside>
                      </Typography>
                    </Popover>
                    <td>
                      <Link
                        to={{
                          pathname: `/block-editAsset?id=${item.id}`,
                        }}
                      >
                        Edit
                      </Link>
                    </td>
                    <td>
                      <Link
                        to={{ pathname: `/block-maintenance?id=${item.id}` }}
                      >
                        <MaintenanceSign />
                      </Link>
                    </td>
                  </tr>
                );
              })}

              {/* <tr>
                <td>1</td>
                <td>National Public School</td>
                <td>School</td>
                <td>Jammu Colony</td>
                <td>4000 sq km</td>
                <td>3</td>
                <td>60</td>
                <td>3</td>
                <td>YES</td>
                <td>YES</td>
                <td>YES</td>
                <td>
                  <a onClick={handleClick}>View More</a>
                </td>
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
                      <PopUpHeading>Additional Details</PopUpHeading>
                      <Details>
                        <AssetOwner>
                          <Left>No. of Floors</Left>
                          <Right>swkfnknfkjm</Right>
                        </AssetOwner>
                        <Year>
                          <Left>Asset Owner</Left>
                          <Right>25005</Right>
                        </Year>
                        <WorkingSpace>
                          <Left>Working Space:</Left>
                          <Right>25551 sq m</Right>
                        </WorkingSpace>
                        <VacantSpace>
                          <Left>Vancant Space:</Left>
                          <Right>4524 sq m</Right>
                        </VacantSpace>
                        <ParkingSpace>
                          <Left>Parking Space:</Left>
                          <Right>4524 sq m</Right>
                        </ParkingSpace>
                        <ImageSection>
                          <ImageHeading>Images</ImageHeading>
                          <Images></Images>
                        </ImageSection>
                      </Details>
                    </PopUpOutside>
                  </Typography>
                </Popover>
              </tr> */}
            </tbody>
          </Table>
        </TableContainer>
      </Container>
      <Footer />
    </>
  );
};

export default BlockStatistics;

const Container = styled.div`
  width: 100vw;
  height: 100vh;
  overflow-y: auto;
  // border: 1px solid black;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  flex-direction: column;
  background-color: #dfffe0;
`;
const Heading = styled.div`
  width: 100vw;
  margin-top: 3%;
  margin-bottom: 3%;
  // border: 1px solid black;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 40px;
  color: #4ba94f; ;
`;
const TableContainer = styled.div`
  // border: 1px solid black;
  overflow-y: auto;
  width: 94%;
  // position: relative;
  // bottom: 40px;
  height: 60%;
  display: flex;
  justify-content: center;
  align-items: flex-start;
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
  //   margin-top: 3%;
  // background-color: #4ba94f;
  width: 100%;
  position: relative;
  left: 107px;
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
const PopUpOutside = styled.div`
  width: 400px;
  height: 300px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  //   border: 1px solid black;
`;

const PopUpHeading = styled.div`
  //   border: 1px solid black;
  font-size: 20px;
  font-weight: 700;
  color: #4ba94f;
  text-align: center;
  width: 100%;
  border-bottom: 1px solid black;
`;
const Details = styled.div`
  //   border: 1px solid black;
  width: 100%;
  margin-top: 3px;
  //   font-weight: 600;
`;
const AssetOwner = styled.div`
  padding: 5px;
  //   border: 1px solid black;
  display: flex;
  justify-content: space-between;
  //   font-weight: 600;
`;
const Year = styled.div`
  padding: 5px;
  //   font-weight: 600;
  //   border: 1px solid black;
  display: flex;
  justify-content: space-between;
`;
const WorkingSpace = styled.div`
  padding: 5px;
  //   border: 1px solid black;
  //   font-weight: 600;
  display: flex;
  justify-content: space-between;
`;
const VacantSpace = styled.div`
  padding: 5px;
  //   font-weight: 600;
  //   border: 1px solid black;
  display: flex;
  justify-content: space-between;
`;
const ParkingSpace = styled.div`
  border-bottom: 1px solid black;
  padding: 5px;
  display: flex;
  justify-content: space-between;
`;
const Left = styled.div`
  font-weight: 600;
`;
const Right = styled.div``;

const ImageSection = styled.div`
  //   border: 1px solid black;
`;
const ImageHeading = styled.div`
  //   border: 1px solid black;
  text-align: center;
  font-size: 20px;
  font-weight: 600;
`;

const Images = styled.div`
  //   border: 1px solid black;
`;
const MaintenanceSign = styled(PrivacyTipIcon)``;
