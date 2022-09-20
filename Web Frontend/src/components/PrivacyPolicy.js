import React from "react";
import styled from "styled-components";
import Footer from "../components/Footer";
import NavbarOfLandingPage from "../components/landingPage/NavbarOfLandingPage";
import { useMediaQuery } from "react-responsive";
import ResponsivePage from "../components/ResponsivePage";

const PrivacyPolicy = () => {
  const isTabletOrMobile = useMediaQuery({ query: "(max-width: 1224px)" });
  return (
    <>
      {isTabletOrMobile && <ResponsivePage />}
      <NavbarOfLandingPage />
      <Container>
        <Card>
          <Heading>Privacy And Policy</Heading>
          <SubHeading>for assetsync.tech</SubHeading>
          <PrivacyAndPolicyContent>
            <h2>Privacy Policy for assetsync.tech</h2>
            At assetsync.tech, accessible from http://assetsync.tech one of our
            main priorities is the privacy of our visitors. This Privacy Policy
            document contains types of information that is collected and
            recorded by assetsync.tech and how we use it. <br />
            <br />
            If you have additional questions or require more information about
            our Privacy Policy, do not hesitate to contact us. This Privacy
            Policy applies only to our online activities and is valid for
            visitors to our website with regards to the information that they
            shared and/or collect in assetsync.tech. This policy is not
            applicable to any information collected offline or via channels
            other than this website. Our Privacy Policy was created with the
            help of the Free Privacy Policy Generator.
            <h2> Consent</h2>By using our website, you hereby consent t Privacyo
            our Policy and agree to its terms.
            <h2> Information we collect</h2> The personal information tha are
            asked to provide, and the reasons why you are asked to provide it,
            will be made clear to you at the point we ask you to provide your
            personal information.
            <br />
            If you contact us directly, we may receive additional information
            about you such as your name, email address, phone number, the
            contents of the message and/or attachments you may send us, and any
            other information you may choose to provide.
            <br />
            <br /> When register for an Account, we may ask for your contact
            information, including items such as name, company name, address,
            email address, and telephone number.
            <br />
            <h2> How we use your information</h2>
            We use the information we collect various ways, including to:
            <br />
            <ul>
              <li>Provide, operate, and maintain our website</li>
              <li>Improve, personalize, and expand our website</li>
              <li>Understand and analyze how you use our website</li>
              <li>
                Develop new products, services, features, and functionality
              </li>
              <li>
                Communicate with you, either directly or through one of our
                partners, including for customer service, to provide you with
                updates and other information relating to the website, and for
                marketing and promotional purposes
              </li>
              <li>Send you emails</li>
              <li>Find and prevent fraud</li>
            </ul>
            <h2>Log Files</h2>
            assetsync.tech follows a standard procedure of using log files.
            These files log visitors when they visit websites. All hosting
            companies do this and a part of hosting services' analytics. The
            information collected by log files include internet protocol (IP)
            addresses, browser type, Internet Service Provider (ISP), date and
            time stamp, referring/exit pages, and possibly the number of clicks.
            These are not linked to any information that is personally
            identifiable. The purpose of the information is for analyzing
            trends, administering the site, tracking users' movement on the
            website, and gathering demographic information.
            <br />
            <br />
            <h2> Advertising Partners Privacy Policies </h2>
            You may consult this list to find the Privacy Policy for each of the
            advertising partners of assetsync.tech.
            <br />
            <br /> Third-party ad servers or ad networks uses technologies like
            cookies, JavaScript, or Web Beacons that are used in their
            respective advertisements and links that appear on assetsync.tech,
            which are sent directly to users' browser. They automatically
            receive your IP address when this occurs. These technologies are
            used to measure the effectiveness of their advertising campaigns
            and/or to personalize the advertising content that you see on
            websites that you visit.
            <br />
            <br /> Note that assetsync.tech has no access to or control over
            these cookies that are used by third-party advertisers.
            <br />
            <br />
            <h2> Third Party Privacy Policies</h2> assetsync.tech's Privacy
            Policy does not apply to other advertisers or websites. Thus, we are
            advising you to consult the respective Privacy Policies of these
            third-party ad servers for more detailed information. It may include
            their practices and instructions about how to opt-out of certain
            options.
            <br />
            <br /> You can choose to disable cookies through your individual
            browser options. To know more detailed information about cookie
            management with specific web browsers, it can be found at the
            browsers' respective websites. <br />
            <br />
            <h2>CCPA Privacy Rights (Do Not Sell My Personal Information)</h2>
            Under the CCPA, among other rights, California consumers have the
            right to:
            <br />
            <br /> Request that a business that collects a cons personalumer's
            data disclose the categories and specific pieces of personal data
            that a business has collected about consumers.
            <br />
            <br /> Request that a business delete any personal data about the
            consumer that a business has collected.
            <br />
            <br /> Request that a business that sells a consumer's personal
            data, not sell the consumer's personal data.
            <br />
            <br /> If you make a request, we have one month to respond to you.
            If you would like to exercise any of these rights, please contact
            us. <br />
            <br />
            <h2>GDPR Data Protection Rights</h2> We would like to make sure you
            are fully aware of all of your data protection rights. Every user is
            entitled to the following:
            <br />
            <br /> The right to access – You have the right to request copies of
            your personal data. We may charge you a small fee for this. <br />
            <br /> The right to rectification – You have the right to request
            that we correct any information you believe is inaccurate. You also
            have the right to request that we complete the information you
            believe is incomplete.
            <br />
            <br /> The right to erasure – You have the right to request that we
            erase your personal data, under certain conditions.
            <br />
            <br /> The right to restrict processing – You have the right to
            request that we restrict the processing of your personal data, under
            certain conditions.
            <br />
            <br /> The right to object to processing – You have the right to
            object to our processing of your personal data, under certain
            conditions.
            <br />
            <br /> The right to data portability – You have the right to request
            that we transfer the data that we have collected to another
            organization, or directly to you, under certain conditions.
            <br /> <br /> If you make a request, we have one month to respond to
            you. If you would like to exercise any of these rights, please
            contact us.
            <br />
            <br />
            <h2> Children's Information</h2>Another part of our priority is
            adding protection for children while using the internet. We
            encourage parents and guardians to observe, participate in, and/or
            monitor and guide their online activity.
            <br />
            <br /> assetsync.tech does not knowingly collect any Personal
            Identifiable Information from children under the age of 13. If you
            think that your child provided this kind of information on our
            website, we strongly encourage you to contact us immediately and we
            will do our best efforts to promptly remove such information from
            our records. <br />
            <br />
            Generated using Privacy Policy Generator
          </PrivacyAndPolicyContent>
        </Card>
      </Container>
      <Footer />
    </>
  );
};

export default PrivacyPolicy;

const Container = styled.div`
  //   border: 1px solid black;
  width: 100vw;
  height: 83.5vh;
  background-color: #dfffe0;
  display: flex;
  justify-content: center;
  align-items: center;
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
const PrivacyAndPolicyContent = styled.div`
  color: black;
  padding: 25px;
  //   border: 1px solid black;
  line-height: 25px;
  text-align: justify;
`;
