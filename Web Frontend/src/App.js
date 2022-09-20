import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

// import Home from "./components/Home";
import LandingPage from "./components/landingPage/LandingPage";
import Login from "./components/Login";
import AboutUs from "./components/landingPage/AboutUs";

import AdminAdministration from "./components/Dashboards/Admin Panel/AdminAdministration";
import AdminDashboard from "./components/Dashboards/Admin Panel/AdminDashboard";
import AdminStatistics from "./components/Dashboards/Admin Panel/AdminStatistics";

import StateAdministration from "./components/Dashboards/State Panel/StateAdministration";
import StateDashboard from "./components/Dashboards/State Panel/StateDashboard";
import StateStatistics from "./components/Dashboards/State Panel/StateStatistics";

import DistrictAdministration from "./components/Dashboards/District Panel/DistrictAdministration";
import DistrictDashboard from "./components/Dashboards/District Panel/DistrictDashboard";
import DistrictStatistics from "./components/Dashboards/District Panel/DistrictStatistics";
import DistrictVerification from "./components/Dashboards/District Panel/DistrictVerification";

import BlockAddAsset from "./components/Dashboards/Block Panel/BlockAddAsset";
import BlockDashboard from "./components/Dashboards/Block Panel/BlockDashboard";
import BlockStatistics from "./components/Dashboards/Block Panel/BlockStatistics";

import PrivacyPolicy from "./components/PrivacyPolicy";
import TermsAndConditions from "./components/TermsAndConditions";
import ViewOnMap from "./components/Dashboards/Block Panel/ViewOnMap";
import BlockEditAsset from "./components/Dashboards/Block Panel/BlockEditAsset";
import BlockMaintenance from "./components/Dashboards/Block Panel/BlockMaintenance";
import DistrictMaintenance from "./components/Dashboards/District Panel/DistrictMaintenance";
import DistrictMaintenanceDetails from "./components/Dashboards/District Panel/DistrictMaintenanceDetails";

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<LandingPage />} />
          {/* <Route path="/home" element={<Home />} /> */}
          <Route path="/login" element={<Login />} />
          <Route path="/about-us" element={<AboutUs />} />
          <Route path="/privacy-policy" element={<PrivacyPolicy />} />
          <Route
            path="/terms-and-conditions"
            element={<TermsAndConditions />}
          />

          <Route path="/admin" element={<AdminDashboard />} />
          <Route
            path="/admin-administration"
            element={<AdminAdministration />}
          />
          <Route path="/admin-statistics" element={<AdminStatistics />} />
          <Route path="/state" element={<StateDashboard />} />
          <Route
            path="/state-administration"
            element={<StateAdministration />}
          />
          <Route path="/state-statistics" element={<StateStatistics />} />
          <Route path="/district" element={<DistrictDashboard />} />
          <Route
            path="/district-administration"
            element={<DistrictAdministration />}
          />
          <Route path="/district-statistics" element={<DistrictStatistics />} />
          <Route
            path="/district-verification"
            element={<DistrictVerification />}
          />
          <Route
            path="/district-maintenance"
            element={<DistrictMaintenance />}
          />
          <Route
            path="/district-maintenance-details"
            element={<DistrictMaintenanceDetails />}
          />

          <Route path="/block" element={<BlockDashboard />} />
          {/* <Route path="/administration" element={<Administration />} />
          <Route path="/statistics" element={<Statistics />} />
          <Route path="/view-on-map" element={<ViewOnMap />} />
          <Route path="/addadmin" element={<AddAdmin />} /> */}

          <Route path="/block-addAsset" element={<BlockAddAsset />} />
          <Route path="/block-editAsset" element={<BlockEditAsset />} />
          <Route path="/block-statistics" element={<BlockStatistics />} />
          <Route path="/block-maintenance" element={<BlockMaintenance />} />

          <Route path="/viewOnMap" element={<ViewOnMap />} />
        </Routes>
      </div>
    </Router>
    // <div className="App">
    // <Home />
    // </div>
  );
}

export default App;
