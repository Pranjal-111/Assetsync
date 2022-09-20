import React, { useEffect, useState } from "react";
import styled from "styled-components";
import NavbarOfDistrict from "./NavbarOfDistrict";
import Accordion from "@mui/material/Accordion";
import AccordionSummary from "@mui/material/AccordionSummary";
import AccordionDetails from "@mui/material/AccordionDetails";
import Typography from "@mui/material/Typography";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";
import ArrowRightAltIcon from "@mui/icons-material/ArrowRightAlt";
import { Link } from "react-router-dom";

const DistrictMaintenance = () => {
  const [data, getData] = useState([]);
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

  useEffect(() => {
    fetchData();
  }, []);
  return (
    <>
      <NavbarOfDistrict />
      <Wrapper>
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
                  <Div>
                    <Link
                      to={{
                        pathname: `/district-maintenance-details?id=${item.id}`,
                      }}
                      // to="/district-maintenance-details?id=${item.id}"
                    >
                      <ArrowRightAltIcon />
                    </Link>
                  </Div>
                </AccordionSummary>
                <AccordionDetails>
                  <Typography>
                    {
                      <ul>
                        <li>{item.name}</li>
                        <li>{item.email}</li>
                        <li>{item.phone}</li>
                      </ul>
                    }
                  </Typography>
                </AccordionDetails>
              </Accordion>
            );
          })}
        </Content>
      </Wrapper>
    </>
  );
};

export default DistrictMaintenance;

const Wrapper = styled.div`
  width: 100vw;
  height: 100vh;
  border: 1px solid black;
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
