const { create, createDistrict, createDistrictBlock, getUserByUsernameState, getUserByUsernameCity,  getUserByUsernameDistrictBlocks, getstate, getcity, createAsset, forgotPassword, changePassword, getUserByUsernameAdmin, getsubblock, getassets, getByTypeonsubblock, getassetsbycity, getByTypeoncity, getassetsbystate, getByTypeonstate, getassetsbyadmin, getByTypeonadmin, getassetsbycityapproved, modifyAssetonApproved, updateAsset, maintainance, cityMaintainance, districtMApproved} = require("./service");

const crypto = require('crypto');  

const sendEmail = require("./utils/sendmail");
var generator = require('generate-password');
const { generateFromEmail, generateUsername } = require("unique-username-generator");
const {sign} = require("jsonwebtoken");





module.exports = {

getStates:(req,res)=>{
    getstate((err,results)=>{
        if(err){
            console.log(err);
            return;
        }
        return res.json({
            success:1,
            data:results
        })
    })
},

getCity:(req,res)=>{
   const body = req.body;
    getcity(body,(err,results)=>{
        if(err){
            console.log(err);
            return;
        }
        return res.status(200).json({
            success:1,
            data:results
        })
    })
},
getSubBlocks:(req,res)=>{
    const body = req.body;
     getsubblock(body,(err,results)=>{
         if(err){
             console.log(err);
             return;
         }
         return res.status(200).json({
             success:1,
             data:results
         })
     })
 },



    createUser: (req, res) => {
        const body = req.body;
        var usernames = body.name;
        usernames = `${usernames}@assetsync.tech`;
        console.log(usernames);
        var password = generator.generate({
            length: 10,
            numbers: true
        });
        console.log(password);
        const secret = 'assetsync';  
        const hash = crypto.createHmac('sha256', secret)  
                           .update(password)  
                           .digest('hex');  
        console.log(hash);
        body.password = hash;
      
        body.username = usernames;

  
        create(body, (error, results) => {
            if (error) {
                console.log(error);
                return res.status(500).json({
                    success: 0,
                    message: `database connection error ${error}`,
                })
            }
            var text = `Yours Username is ${body.username} and Password is ${password}`;
            sendEmail(body.email, "Authentication Credentials", text);
            return res.status(200).json({
                success: 1,
                data: results,
                message: "1"
            })

        })
      },

createDistricts: (req, res) => {
    const body = req.body;
    var usernames = body.name;
        usernames = `${usernames}@assetsync.tech`;
    console.log(usernames);
    var password = generator.generate({
        length: 10,
        numbers: true
    });
    console.log(password);
    const secret = 'assetsync';  
    const hash = crypto.createHmac('sha256', secret)  
                       .update(password)  
                       .digest('hex');  
    console.log(hash);
    body.password = hash;
    body.username = usernames;


    createDistrict(body, (error, results) => {
        if (error) {
            console.log(error);
            return res.status(500).json({
                success: 0,
                message: "Database connection error",
            })
        }
        var text = `Yours Username is ${body.username} and Password is ${password}`;
        sendEmail(body.email, "Authentication Credentials", text);
        return res.status(200).json({
            success: 1,
            data: results,
            message: "1"
        })

    })
  },
  createDistrictBlocks: (req, res) => {
    const body = req.body;
    var usernames = body.name;
    usernames = `${usernames}@assetsync.tech`;
    console.log(usernames);
    var password = generator.generate({
        length: 10,
        numbers: true
    });
    console.log(password);
    const secret = 'assetsync';  
    const hash = crypto.createHmac('sha256', secret)  
                       .update(password)  
                       .digest('hex');  
    console.log(hash);
    body.password = hash;
    body.username = usernames;


    createDistrictBlock(body, (error, results) => {
        if (error) {
            console.log(error);
            return res.status(500).json({
                success: 0,
                message: "Database connection error",
            })
        }
        var text = `Yours Username is ${body.username} and Password is ${password}`;
        sendEmail(body.email, "Authentication Credentials", text);
        return res.status(200).json({
            success: 1,
            data: results,
            message: "1"
        })

    })
  },
  loginAdmins:(req,res)=>{
    const body = req.body;
    getUserByUsernameAdmin((err,results)=>{
        if(err){
            console.log(err);
        }
        if(!results){
            return res.json({
                success:0,
                data:"user not exist"
            })
        }
        var result = false;
        const secret = 'assetsync';  
        const hash = crypto.createHmac('sha256', secret)  
                           .update(body.password)  
                           .digest('hex');  
        console.log(hash);
        const encrypt = results.password;
       if(hash===encrypt){
        result = true;
       }

        if(result){
            results.password = undefined;
            const jwttoken = sign({result : results},"hjybuhuhuh",{
                expiresIn:"1h"
            })
            return res.json({
                success:1,
                message:"Login succesfully",
                token:jwttoken,
                data:results
            })
        }
        else{
            return res.json({
                success:0,
                data:"Invalid username "
            })
        }
    })
},
  loginState:(req,res)=>{
    const body = req.body;
    getUserByUsernameState(body.username,(err,results)=>{
        if(err){
            console.log(err);
        }
        if(!results){
            return res.json({
                success:0,
                data:"user not exist"
            })
        }
        var result = false;
        const secret = 'assetsync';  
        const hash = crypto.createHmac('sha256', secret)  
                           .update(body.password)  
                           .digest('hex');  
        console.log(hash);
        const encrypt = results.password;
       if(hash===encrypt){
        result = true;
       }

        if(result){
            results.password = undefined;
            const jwttoken = sign({result : results},"hjybuhuhuh",{
                expiresIn:"1h"
            })
            return res.json({
                success:1,
                message:"Login succesfully",
                token:jwttoken,
                data:results
            })
        }
        else{
            return res.json({
                success:0,
                data:"Invalid username "
            })
        }
    })
},
loginCity:(req,res)=>{
    const body = req.body;
    getUserByUsernameCity(body.username,(err,results)=>{
        if(err){
            console.log(err);
        }
        if(!results){
            return res.json({
                success:0,
                data:"Invalid username or password"
            })
        }
        var result = false;
        const secret = 'assetsync';  
        const hash = crypto.createHmac('sha256', secret)  
                           .update(body.password)  
                           .digest('hex');  
        console.log(hash);
        const encrypt = results.password;
       if(hash===encrypt){
        result = true;
       }

        if(result){
            results.password = undefined;
            const jwttoken = sign({result : results},"hjybuhuhuh",{
                expiresIn:"1h"
            })
            return res.json({
                success:1,
                message:"Login succesfully",
                token:jwttoken,
                data:results
            })
        }
        else{
            return res.json({
                success:0,
                data:"Invalid username or password"
            })
        }
    })
},
loginDistrictBlock:(req,res)=>{
    const body = req.body;
    getUserByUsernameDistrictBlocks(body.username,(err,results)=>{
        if(err){
            console.log(err);
        }
        if(!results){
            return res.json({
                success:0,
                data:"Invalid username or password"
            })
        }
        var result = false;
        const secret = 'assetsync';  
        const hash = crypto.createHmac('sha256', secret)  
                           .update(body.password)  
                           .digest('hex');  
        console.log(hash);
        const encrypt = results.password;
       if(hash===encrypt){
        result = true;
       }

        if(result){
            results.password = undefined;
            const jwttoken = sign({result : results},"hjybuhuhuh",{
                expiresIn:"1h"
            })
            return res.json({
                success:1,
                message:"Login succesfully",
                token:jwttoken,
                data:results
            })
        }
        else{
            return res.json({
                success:0,
                data:"Invalid username or password"
            })
        }
    })
},
createUser: (req, res) => {
    const body = req.body;
    var usernames = body.name;
    usernames = `${usernames}@assetsync.tech`;
    console.log(usernames);
    var password = generator.generate({
        length: 10,
        numbers: true
    });
    console.log(password);
    const secret = 'assetsync';  
    const hash = crypto.createHmac('sha256', secret)  
                       .update(password)  
                       .digest('hex');  
    console.log(hash);
    body.password = hash;
  
    body.username = usernames;


    create(body, (error, results) => {
        if (error) {
            console.log(error);
            return res.status(500).json({
                success: 0,
                message: `database connection error ${error}`,
            })
        }
        var text = `Yours Username is ${body.username} and Password is ${password}`;
        sendEmail(body.email, "Authentication Credentials", text);
        return res.status(200).json({
            success: 1,
            data: results,
            message: "1"
        })

    })
  },
//   createAssets: (req, res) => {
//     const body = req.body;
//     createAsset(body, (error, results) => {
//         if (error) {
//             console.log(error);
//             return res.status(500).json({
//                 success: 0,
//                 message: `database connection error ${error}`,
//             })
//         }
//         return res.status(200).json({
//             success: 1,
//             data: results,
//             message: "1"
//         })

//     })
//   },
createAssets: (req, res) => {
    
    var data = req.body;
    

    createAsset(data,(error, results) => {
                if (error) {
                    console.log(error);
                    return res.status(500).json({
                        success: 0,
                        message: `database connection error ${error}`,
                    })
                }
                console.log(results);
                return res.json({
                    success: 1,
                    data: results,
                    message: "1"
                })
        
            });
     
},
getAssets:(req,res)=>{
    var body = req.body;
    getassets(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getAssetcity:(req,res)=>{
    var body = req.body;
    getassetsbycity(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getAssetstate:(req,res)=>{
    var body = req.body;
    getassetsbystate(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getAssetadmin:(req,res)=>{
 getassetsbyadmin((error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getByTypeonsubblocks:(req,res)=>{
    var body = req.body;
    getByTypeonsubblock(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getByTypeoncitys:(req,res)=>{
    var body = req.body;
    getByTypeoncity(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getByTypeonstates:(req,res)=>{
    var body = req.body;
    getByTypeonstate(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
getByTypeonadmins:(req,res)=>{
 getByTypeonadmin((error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},

getDistrictBlock:(req,res)=>{
    getdistrictblock((err,results)=>{
        if(err){
            console.log(err);
            return;
        }
        return res.json({
            success:1,
            data:results
        })
    })
},
forgetPasswords:(req,res)=>{
    const body = req.body;
    var password = generator.generate({
        length: 10,
        numbers: true
    });
    console.log(password);
    const secret = 'assetsync';  
    const hash = crypto.createHmac('sha256', secret)  
                       .update(password)  
                       .digest('hex');  
    console.log(hash);
    body.password = hash;
    forgotPassword(body,(err,results)=>{
        if(err){
            console.log(err);
        }
        if(!results){
            return res.json({
                success:0,
                data:"user not exist"
            })
        }
        console.log(results.email);
        var text = `Yours Username is ${body.username} and Password is ${password}`;
        sendEmail(results.email, "Authentication Credentials", text);
        return res.status(200).json({
            success: 1,
            data: results,
            message: "1"
        })
        


    }
    )

},
changePasswords:(req,res)=>{
    const body = req.body;
 
   
    const secret = 'assetsync';  
    const currentpassword = crypto.createHmac('sha256', secret)  
                       .update(body.password)  
                       .digest('hex');  
  
    body.password = currentpassword;
    const newPassword = crypto.createHmac('sha256', secret)  
    .update(body.newPassword)  
    .digest('hex');
    body.newPassword = newPassword;  
    changePassword(body,(err,results)=>{
        if(err){
            return res.json({
                success:0,
                data:err
            });   
        }
        else if(!results){
            return res.json({
                success:0,
                data:"user name not exist"
            })
        }
        return res.status(200).json({
                success: 1,
                data: results,
                message: "Password change Succesfully"
            })
            
        
       
        


    }
    )

},


getVerifyAsset:(req,res)=>{
    var body = req.body;
    getassetsbycityapproved(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},

districtApproved:(req,res)=>{
    var body = req.body;
    modifyAssetonApproved(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},

editAssets:(req,res)=>{
    var body = req.body;
    updateAsset(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},

addMaintainance:(req,res)=>{
    var body = req.body;
    maintainance(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
citymaintenance:(req,res)=>{
    var body = req.body;
   cityMaintainance(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},
districtMapproved:(req,res)=>{
    var body = req.body;
    console.log(body);
  districtMApproved(body,(error,results)=>{
        if(error){
            console.log(error);
            return res.status(500).json({
                success:0,
                message:`DataBase Connection error ${error}`
            })
        }
        console.log(results);
        return res.json({
            suucess:1,
            data:results,
            message:"1"
        })
    })
},







}








