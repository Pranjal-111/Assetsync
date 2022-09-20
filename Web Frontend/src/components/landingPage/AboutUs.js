import React from "react";
import styled from "styled-components";
import Footer from "../Footer";
import NavbarOfLandingPage from "./NavbarOfLandingPage";
import { useMediaQuery } from "react-responsive";
import ResponsivePage from "../ResponsivePage";

const AboutUs = () => {
  const isTabletOrMobile = useMediaQuery({ query: "(max-width: 1224px)" });
  return (
    <>
      {isTabletOrMobile && <ResponsivePage />}
      <NavbarOfLandingPage />
      <Container>
        <Card>
          <Heading>About Us</Heading>
          <SubHeading>Assets Sync: Management App</SubHeading>
          <AboutUsContent>
            Since its launch on 26th July 2014, by Hon'ble Prime Minister, Shri
            Narendra Modi, MyGov has more than 24.5 million registered users.
            Almost all Government Departments leverage MyGov platform for their
            citizen engagement activities, consultations for policy formulation
            and also to disseminate information to citizens for various
            Government schemes and programs. MyGov is amongst the most active
            profiles on Social Media - Twitter, Facebook, Instagram, YouTube &
            LinkedIn with the username @MyGovindia. MyGov has a significant
            presence on several Indian social media platforms like Koo,
            Sharechat, Chingari, Roposo, Bolo Indya and Mitron. MyGov has
            adopted multiple engagement methodologies like discussions, tasks,
            polls, surveys, blogs, talks, pledges, quizzes and on-ground
            activities by innovatively using internet, mobile apps, IVRS, SMS
            and outbound dialling (OBD) technologies.
            <br />
            <br /> MyGov has also launched State instances in 18 States, namely
            Himachal Pradesh, Haryana, Maharashtra, Madhya Pradesh, Arunachal
            Pradesh, Assam, Manipur, Tripura, Chhattisgarh, Jharkhand, Nagaland,
            Uttarakhand, Goa, Tamil Nadu, Uttar Pradesh, Jammu & Kashmir,
            karnataka and Gujarat. <br />
            <br /> MyGov is part of Digital India Corporation, a Section 8
            company under Ministry of Electronics and IT, Government of India.{" "}
            <br />
            <br /> MyGov has had significant success in terms of engaging with
            citizens. Logos and Tagline of key National Projects have been
            crowdsourced through MyGov. Few Notable crowdsourced initiatives are
            Logo for Swachh Bharat, Logo for National Education Policy, Logo for
            Digital India Campaign, etc. MyGov has time and again solicited
            inputs of draft policies from citizens few of those are National
            Education Policy, Data Centre Policy, Data Protection Policy,
            National Ports Policy, IIM Bill etc. MyGov have also been frequently
            soliciting ideas for Mann Ki Baat, Annual Budget, Pariksha Pe
            Charcha and many more such initiatives.
            <br />
            <br />
            MyGov has also launched State instances in 18 States, namely
            Himachal Pradesh, Haryana, Maharashtra, Madhya Pradesh, Arunachal
            Pradesh, Assam, Manipur, Tripura, Chhattisgarh, Jharkhand, Nagaland,
            Uttarakhand, Goa, Tamil Nadu, Uttar Pradesh, Jammu & Kashmir,
            karnataka and Gujarat. <br /> MyGov is part of Digital India
            Corporation, a Section 8 company under Ministry of Electronics and
            IT, Government of India. <br /> MyGov has had significant success in
            terms of engaging with citizens. Logos and Tagline of key National
            Projects have been crowdsourced through MyGov. Few Notable
            crowdsourced initiatives are Logo for Swachh Bharat, Logo for
            National Education Policy, Logo for Digital India Campaign, etc.
            MyGov has time and again solicited inputs of draft policies from
            citizens few of those are National Education Policy, Data Centre
            Policy, Data Protection Policy, National Ports Policy, IIM Bill etc.
            MyGov have also been frequently soliciting ideas for Mann Ki Baat,
            Annual Budget, Pariksha Pe Charcha and many more such initiatives.
          </AboutUsContent>
        </Card>
      </Container>
      <Footer />
    </>
  );
};

export default AboutUs;

const Container = styled.div`
  //   border: 1px solid black;
  width: 100vw;
  height: 83.5vh;
  background-color: #dfffe0;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow-y: auto;
`;

const Card = styled.div`
  border: 2px solid #4ba94f;
  box-shadow: rgba(99, 99, 99, 0.2) 0px 7px 30px 7px;
  overflow-y: auto;
  border-radius: 10px;
  background-color: white;
  width: 95vw;
  height: 75vh;
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
    background: grey;
    border-radius: 10px;
  }

  /* Handle on hover */
  &::-webkit-scrollbar-thumb:hover {
    background: black;
  }
`;

const Heading = styled.div`
  //   border: 1px solid black;
  //   border-bottom: 1px solid #4ba94f;
  color: #4ba94f;
  font-size: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 4px 4px 0 4px;
`;

const SubHeading = styled.div`
  color: #4ba94f;
  font-size: 25px;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 4px 4px 0 4px;
`;
const AboutUsContent = styled.div`
  color: black;
  padding: 25px;
  // border: 1px solid black;
  line-height: 25px;
  display: flex;
  justufy-content: center;
  align-items: center;
  text-align: justify;
`;
