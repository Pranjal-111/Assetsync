import React, { useState, useEffect } from "react";
import styled from "styled-components";
import Footer from "../../Footer";
import NavbarOfBlock from "../Block Panel/NavbarOfBlock";
// import Card from "../../Card";

const BlockDashboard = () => {
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
  // console.log(data[0].type);
  return (
    <>
      <NavbarOfBlock />
      <Container>
        <Heading>Top Assets</Heading>
        {/* <Division>
          <Carding>
            <CardTitle>
              <Name>{1}</Name>
              <Headings>
                <Head>{data[0].type}</Head>
                <SubHead>Total {data[0].type}:</SubHead>
              </Headings>
            </CardTitle>
            <Number>
              <span>{data[0].count}</span>
            </Number>
          </Carding>
          <Carding>
            <CardTitle>
              <Name>{2}</Name>
              <Headings>
                <Head>{data[1].type}</Head>
                <SubHead>Total {data[1].type}:</SubHead>
              </Headings>
            </CardTitle>
            <Number>
              <span>{data[1].count}</span>
            </Number>
          </Carding>
          <Carding>
            <CardTitle>
              <Name>{3}</Name>
              <Headings>
                <Head>{data[2].type}</Head>
                <SubHead>Total {data[2].type}:</SubHead>
              </Headings>
            </CardTitle>
            <Number>
              <span>{data[2].count}</span>
            </Number>
          </Carding>
        </Division> */}
        <TableContainer>
          <ScrollBar>
            <Table>
              <thead>
                <tr>
                  <th>Sr.No.</th>
                  <th>Credentials</th>
                  <th>No. of Assets</th>
                </tr>
              </thead>
              <tbody>
                {data.map((item, i) => {
                  return (
                    <tr key={i}>
                      <td>{i + 1}</td>
                      <td>{item.type}</td>
                      <td>{item.count}</td>
                    </tr>
                  );
                })}
                {/* <tr>
                  <td>1</td>
                  <td>Anurag</td>
                  <td>+917025440795</td>
                </tr> */}
              </tbody>
            </Table>
          </ScrollBar>
        </TableContainer>
      </Container>
      <Footer />
    </>
  );
};

export default BlockDashboard;

const Container = styled.div`
  width: 100vw;
  height: 100vh;
  // border: 1px solid black;
  background-color: #dfffe0;
`;
const Heading = styled.div`
  // border: 1px solid black;
  font-size: 40px;
  width: 100%;
  text-align: center;
  color: #4ba94f;
  padding-top: 2%;
  font-weight: 500;
`;
const Division = styled.div`
  // border: 1px solid black;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  // margin-top: 5%;
  margin-top: 2%;
`;
const Carding = styled.div`
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

const TableContainer = styled.div`
  // border: 1px solid black;
  width: 100%;
  height: 50%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  flex-direction: column;
  margin-top: 3%;
`;
const ScrollBar = styled.div`
  overflow-y: auto;
  border-collapse: collapse;
  // box-shadow: rgba(99, 99, 99, 0.2) 0px 4px 8px 0px;
  width: 75%;
  // border: 1px solid black;
  height: 70%;
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
