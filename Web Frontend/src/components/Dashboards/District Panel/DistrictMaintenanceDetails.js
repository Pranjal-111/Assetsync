import React, { useState, useEffect } from "react";
import styled from "styled-components";
import NavbarOfDistrict from "./NavbarOfDistrict";
import Accordion from "@mui/material/Accordion";
import AccordionSummary from "@mui/material/AccordionSummary";
import AccordionDetails from "@mui/material/AccordionDetails";
import Typography from "@mui/material/Typography";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import ArrowRightAltIcon from "@mui/icons-material/ArrowRightAlt";
import { Link } from "react-router-dom";

const DistrictMaintenanceDetails = () => {
  const [id, setId] = useState();
  console.log(id);

  const fetchId = () => {
    let search = window.location.search;
    const urlParams = new URLSearchParams(search);
    const ids = urlParams.get("id");
    console.log(ids);
    setId(ids);
  };
  useEffect(() => {
    fetchId();
  }, []);

  const [data, getData] = useState([]);

  async function fetchData() {
    // console.warn(username, password);
    var data = localStorage.getItem("user-info");
    var dataa = JSON.parse(data);
    var sub_area_id = dataa.id;

    let item = { sub_area_id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/city/maintainance",
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
  const Approved = async (isApproved, id) => {
    // console.warn(username, password);

    let item = { isApproved, id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/district/mainpproved",
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

  return (
    <>
      <NavbarOfDistrict />
      <Division>
        <Content>
          {data.map((item, i) => {
            return (
              <Accordion key={i}>
                <AccordionSummary
                  expandIcon={<ExpandMoreIcon />}
                  aria-controls="panel1a-content"
                  id="panel1a-header"
                >
                  <Typography>{item.name}</Typography>
                  {/* <Div>
                    <Link
                      to={{
                        pathname: `/district-maintenance-details?id=${item.id}`,
                      }}
                      // to="/district-maintenance-details?id=${item.id}"
                    >
                      <ArrowRightAltIcon />
                    </Link>
                  </Div> */}
                </AccordionSummary>
                <AccordionDetails>
                  <Typography>
                    {
                      <ul>
                        <li>{item.name}</li>
                        <li>{item.budget}</li>
                        <li>{item.type}</li>
                        <li>{item.proposal}</li>
                        <li>{item.requirement}</li>
                      </ul>
                    }
                  </Typography>
                  <Div>
                  
                    <a onClick={() => Approved(true, item.id)}>Accept</a>
                    <a
                        onClick={() => Approved(false, item.id)}
                      style={{ color: "red", marginLeft: "100px" }}
                    >
                      Reject
                    </a>
                  </Div>
                </AccordionDetails>
              </Accordion>
            );
          })}
        </Content>
      </Division>
    </>
  );
};

export default DistrictMaintenanceDetails;

const Division = styled.div`
  width: 100vw;
  height: 100vh;
  border: 1px solid #dfffe0;
  background-color: #dfffe0;
  display: flex;
  align-items: flex-start;
  justify-content: center;
`;
const Content = styled.div`
  width: 90vw;
`;
const Div = styled.div`
  // border: 1px solid black;
  color: #4ba94f;
  font-size: 25px;
  cursor: pointer;
  margin: 0 5px;
`;
