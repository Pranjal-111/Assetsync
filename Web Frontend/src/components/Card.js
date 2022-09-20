import React, { useState, useEffect } from "react";
import styled from "styled-components";

const Card = () => {
  const [data, getData] = useState([]);
  async function fetchData() {
    // console.warn(username, password);
    var data = localStorage.getItem("user-info");
    var dataa = JSON.parse(data);
    var sub_area_id = dataa.id;

    let item = { sub_area_id };
    console.log(item);
    let result = await fetch(
      "https://assetasync.herokuapp.com/api/subblock/home",
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
    <Cards>
      {/* {data.map((item, i) => {
                  return (
                    <tr key={i}>
                      <td>{i < 3 && (i + 1)}</td>
                      <td>{i < 3 && (item.type)}</td>
                      <td>{i < 3 && (item.count)}</td> 
                    </tr>
                  );
                })} */}
      {/* {data.map((item, i) => {
                  return (
                    <tr key={i}>
                      <td>{i < 3 && (i + 1)}</td>
                      <td>{i < 3 && (item.type)}</td>
                      <td>{i < 3 && (item.count)}</td> 
                    </tr>
                  );
                })} */}
      {data.map((item, i) => {
        return (
          // <tr key={i}>
          //   <td>{i < 3 && (i + 1)}</td>
          //   <td>{i < 3 && (item.type)}</td>
          //   <td>{i < 3 && (item.count)}</td>
          // </tr>
          <CardTitle>
            <Name>{i && i + 1}</Name>
            <Headings>
              <Head>Schools</Head>
              <SubHead>Total School</SubHead>
            </Headings>
          </CardTitle>
          // <Number>
          //   <span>250</span>
          // </Number>
        );
      })}
      {/* <CardTitle>
        <Name>A</Name>
        <Headings>
          <Head>Schools</Head>
          <SubHead>Total School</SubHead>
        </Headings>
      </CardTitle>
      <Number>
        <span>250</span>
      </Number> */}
    </Cards>
  );
};

export default Card;

const Cards = styled.div`
  border: 2px solid #4ba94f;
  display: flex;
  flex-direction: column;
  width: 20rem;
  height: 13.5rem;
  border-radius: 9px;
  background-color: white;
  box-shadow: rgba(99, 99, 99, 0.2) 2px 3px 10px 6px;
`;
const CardTitle = styled.div`
  //   border: 2px solid blue;
  padding: 15px;
  display: flex;
`;
const Name = styled.div`
  border-radius: 50%;
  border: 1px solid black;
  display: inline;
  padding: 5px;
  width: 10%;
  font-size: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  background: #4ba94f;
  color: white;
`;
const Headings = styled.div`
  width: 80%;
  //   border: 1px solid black;
  display: flex;
  align-items: start;
  padding-left: 10px;
  flex-direction: column;
  justify-content: flex-start;
`;
const Head = styled.div`
  //   border: 1px solid black;
  font-weight: 500;
`;
const SubHead = styled.div`
  //   border: 1px solid black;
  font-size: 13px;
  padding: 2px;
`;

const Number = styled.div`
  //   border: 2px solid blue;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0;
  //   padding: 7px;
  span {
    font-size: 57px;
    color: #4ba94f;
  }
`;
