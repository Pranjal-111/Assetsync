const {createUser,loginState, createDistricts, createDistrictBlocks,  loginCity, loginDistrictBlock, getStates, getCity,  createAssets, forgetPasswords, changePasswords, loginAdmins, getSubBlocks, getAssets, getByTypeonsubblocks, getAssetcity, getByTypeoncity, getByTypeoncitys, getAssetstate, getByTypeonstates, getAssetadmin, getByTypeonadmin, getByTypeonadmins, getVerifyAsset, districtApproved, editAssets, addMaintainance, citymaintenance, districtMapproved, } = require("./controller");
const router = require("express").Router();
// const {checkToken}  = require("../Auth/token_validation")
const cors = require('cors');
const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
    destination: 'assets_images',
    filename: (req, file, cb) => {
        return cb(null, `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`)
    }
});
const upload = multer({
    storage: storage,
}).array('images');


router.post("/admin/createState",createUser);
router.post("/state/login",cors(),loginState);
router.post("/admin/login",loginAdmins)
router.post("/city/login",cors(),loginCity);
router.post("/subblock/login",cors(),loginDistrictBlock);
router.post("/state/createDistrict",createDistricts)
router.post("/city/createDistrictBlocks",createDistrictBlocks)
router.get("/admin/getstate",getStates);
router.post("/state/getcitys",getCity);
router.post("/city/getsubblock",getSubBlocks);
router.post("/subblock/addAssets",createAssets);
router.post("/forgotpasswords",forgetPasswords);
router.post("/changepasswords",changePasswords);
router.post("/subblock/getassets",getAssets);
router.post("/subblock/home",getByTypeonsubblocks);
router.post("/city/getassets",getAssetcity);
router.post("/city/homes",getByTypeoncitys)
router.post("/state/getAsset",getAssetstate);
router.post("/state/homes",getByTypeonstates);
router.get("/admin/getAsset",getAssetadmin);
router.get("/admin/homes",getByTypeonadmins);
router.post("/district/verification",getVerifyAsset);
router.post("/district/approved",districtApproved);
router.post("/subblock/edit",editAssets);
router.post("/subblock/maintanance",addMaintainance);
router.post("/city/maintainance",citymaintenance)
router.post("/district/mainpproved",districtMapproved);




module.exports = router;