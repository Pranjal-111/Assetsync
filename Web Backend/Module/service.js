const pool = require("../config/database");
const nodemailer = require("nodemailer");

module.exports = {

    create: (data, callback) => (
        pool.query(
            `insert into admin (id,name,email,phone,password,username)
            values(?,?,?,?,?,?)`,
            [
                data.id,
                data.name,
                data.email,
                data.phone,
                data.password,
                data.username
            ],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    console.log(results);
                    pool.query(
                        `insert into states (id,name,admin_id)
                    values(?,?,?)`,
                        [
                            data.id,
                            data.name,
                            results.insertId

                        ],
                        (error, results2, fields) => {
                            if (error) {
                                return callback(error)
                            }
                            else {
                                return callback(null, results2)
                            }

                        }
                    )

                }
            }
        )
    ),

    createDistrict: (data, callback) => (
        pool.query(
            `insert into admin (id,name,email,phone,password,username)
            values(?,?,?,?,?,?)`,
            [
                data.id,
                data.name,
                data.email,
                data.phone,
                data.password,
                data.username
            ],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    pool.query(
                        `insert into district (id,state_id,name,admin_id)
                    values(?,?,?,?)`,
                        [
                            data.id,
                            data.state_id,
                            data.name,
                            results.insertId

                        ],
                        (error, results, fields) => {
                            if (error) {
                                return callback(error)
                            }
                            else {
                                return callback(null, results)
                            }

                        }
                    )

                }
            }
        )
    ),
    createDistrictBlock: (data, callback) => (
        pool.query(
            `insert into admin (id,name,email,phone,password,username)
            values(?,?,?,?,?,?)`,
            [
                data.id,
                data.name,
                data.email,
                data.phone,
                data.password,
                data.username
            ],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    pool.query(
                        `insert into sub_area (id,state_id,district_id,name,admin_id)
                    values(?,?,?,?,?)`,
                        [
                            data.id,
                            data.state_id,
                            data.district_id,
                            data.name,
                            results.insertId

                        ],
                        (error, results, fields) => {
                            if (error) {
                                return callback(error)
                            }
                            else {
                                return callback(null, results)
                            }

                        }
                    )

                }
            }
        )
    ),
    getUserByUsernameAdmin: (callback) => {
        pool.query(
            `select * from admin where id = 1`,

            (error, results, fields) => {
                console.log(results)
                if (error) {
                    callback(error);
                }
                return callback(null, results[0]);
            }
        )
    },
    getUserByUsernameState: (username, callback) => {
        pool.query(
            `select * from admin,states where admin.id = states.admin_id and username = ?`,
            [username],
            (error, results, fields) => {
                console.log(results)
                if (error) {
                    callback(error);
                }
                return callback(null, results[0]);
            }
        )
    },
    getUserByUsernameCity: (username, callback) => {
        pool.query(
            `select * from admin,district where admin.id = district.admin_id and username = ?`,
            [username],
            (error, results, fields) => {
                console.log(results)
                if (error) {
                    callback(error);
                }
                return callback(null, results[0]);
            }
        )
    },
    getUserByUsernameDistrictBlocks: (username, callback) => {
        pool.query(
            'select * from admin , sub_area where admin.id = sub_area.admin_id and username =? ',
            [username],
            (error, results, fields) => {
                console.log(results)
                if (error) {
                    callback(error);
                }
                return callback(null, results[0]);
            }
        )
    },

    // createAsset: (data, callback) => (
    //     pool.query(
    //         `insert into asset (id,state_id,district_id,sub_area_id,name,type,address,size,capacity ,present_use,yaer_of_est,rooms,labs,maintance,floors,owner,working_space,vaccant_space,parking,lon,lat)
    //         values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
    //         [
    //             data.id,
    //             data.state_id,
    //             data.district_id,
    //             data.sub_area_id,
    //             data.name,
    //             data.type,
    //             data.address,
    //             data.size,
    //             data.capacity,
    //             data.present_use,
    //             data.year_of_est,
    //             data.rooms,
    //             data.labs,
    //             data.maintance,
    //             data.floors,
    //             data.owner,
    //             data.working_space,
    //             data.vaccant_space,
    //             data.parking,
    //             data.lon,
    //             data.lat,
    //         ],
    //         (error, results, fields) => {
    //             if (error) {
    //                 return callback(error)
    //             }
    //             else {
    //                 return callback(null, results)
    //             }

    //         }


    //     )
    // ),
    // createAsset:  async(data) => {
    //     const connection = await pool.getConnection();
    //     try {
    //         await connection.beginTransaction();
    //         const queryResult = await connection.query(
    //             `insert into assets (id,state_id,district_id,admin_id,posted_by,name,type,location,owner,size,year_of_establishment,working,vacnat,parking,maintenance,floor,rooms,labs,image1,image2)
    //         values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
    //         [
    //             data.id,
    //             data.state_id,
    //             data.district_id,
    //             data.admin_id,
    //             data.posted_by,
    //             data.name,
    //              data.type,
    //             data.location,
    //             data.owner,
    //             data.size,
    //             data.year,
    //             data.working,
    //             data.vacnat,
    //             data.parking,
    //             data.maintenance,
    //             data.floor,
    //             data.rooms,
    //             data.labs,
    //             data.image1,
    //             data.image2,
    //         ],
    //         );
    //         const fetchResult = await connection.query(
    //             `SELECT id,name,CONCAT('http://192.168.8.140:3000/upload/',image1) as image1,
    //             CONCAT('http://192.168.8.140:3000/upload/',image2) as image2
    //             FROM assets WHERE id = ?`, [queryResult[0].insertId]
    //         );
    //         await connection.commit();
    //         return fetchResult[0][0];
    //     } catch (error) {
    //         return error;
    //     } finally {
    //         connection.release();
    //     }
    // },

    getstate: callback => {
        pool.query(
            `select * from admin,states where states.admin_id = admin.id`,
            [],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }



            }
        )
    },
    getcity: (body, callback) => {
        pool.query(
            `select * from admin,states ,district WHERE admin.id = district.admin_id AND states.id = district.state_id AND  states.id = ?`,
            [body.state_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getsubblock: (body, callback) => {
        pool.query(
            ` select * from admin,states ,district, sub_area WHERE admin.id = sub_area.admin_id and district.id = sub_area.district_id AND states.id = sub_area.state_id and district.id = ?`,
            [body.district_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },



    forgotPassword: (data, callback) => {
        pool.query(
            `select * from admin where username = ?`,
            [data.usernames],
            (error, results, fields) => {
                console.log(results)
                if (error) {
                    callback(error);
                }
                else {
                    pool.query(`update admin set password = ? where username = ?`,
                        [data.password, data.usernames],
                        (error, result, fields) => {
                            if (error) {
                                return callback(error)
                            }
                            else {
                                return callback(null, results[0]);

                            }

                        }
                    )
                }
            }
        )
    },
    changePassword: (data, callback) => {
        pool.query(
            `select * from admin where username = ?`,
            [data.username],
            (error, results, fields) => {
                if (error) {
                    callback(error);
                }
                else if (results.length === 0) {
                    callback("user not found")
                }
                else if (results[0].password === data.password) {
                    pool.query(`update admin set password = ? where username = ?`,
                        [data.newPassword, data.username],
                        (error, result, fields) => {
                            if (error) {
                                return callback(error)
                            }
                            else {
                                return callback(null, result);

                            }

                        }
                    )
                }
                else {
                    return callback("Password not match");

                }
            }
        )
    },
    getassets: (body, callback) => {
        pool.query(
            `SELECT * FROM asset WHERE asset.sub_area_id = ? and isApproved = true`,
            [body.sub_area_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getassetsbycity: (body, callback) => {
        pool.query(
            `SELECT * FROM asset WHERE asset.district_id = ? and isApproved = true`,
            [body.district_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getassetsbystate: (body, callback) => {
        pool.query(
            `SELECT * FROM asset WHERE asset.state_id = ? and isApproved = true`,
            [body.state_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getassetsbyadmin: (callback) => {
        pool.query(
            `SELECT * FROM asset where isApproved = true `,
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getByTypeonsubblock: (body, callback) => {
        pool.query(
            `SELECT type,COUNt(*) as count  FROM asset WHERE asset.sub_area_id = ?  and isApproved = true GROUP by type ORDER BY COUNT(*) DESC;`,
            [body.sub_area_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getByTypeoncity: (body, callback) => {
        pool.query(
            `SELECT type,COUNt(*) as count  FROM asset WHERE asset.district_id = ? and isApproved = true GROUP by type ORDER BY COUNT(*) DESC;`,
            [body.district_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
  
    getByTypeonadmin: (callback) => {
        pool.query(
            `SELECT type,COUNt(*) as count  FROM asset where isApproved = true GROUP by type ORDER BY COUNT(*) DESC;`,

            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    getByTypeonstate: (body, callback) => {
        console.log(body.state_id);
        pool.query(
            `SELECT type,COUNt(*) as count  FROM asset WHERE asset.state_id = ?  and isApproved = true GROUP by type ORDER BY COUNT(*) DESC;`,
            [body.state_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    createAsset: (data, callback) => (
        pool.query(
            `insert into asset (id,state_id,district_id,sub_area_id,name,type,address,size,capacity ,present_use,yaer_of_est,rooms,labs,maintance,floors,owner,working_space,vaccant_space,parking,lon,lat)
            values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,
            [
                data.id,
                data.state_id,
                data.district_id,
                data.sub_area_id,
                data.name,
                data.type,
                data.address,
                data.size,
                data.capacity,
                data.present_use,
                data.year_of_est,
                data.rooms,
                data.labs,
                data.maintance,
                data.floors,
                data.owner,
                data.working_space,
                data.vaccant_space,
                data.parking,
                data.lon,
                data.lat,
            ],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                // else {

                // console.log(results);
                // // for (var i in data.image) {
                // //     console.log(i);
                // //   var val = data.image[i];
                // //   console.log(val);
                // //   console.log(data.image_id,results.insertId,val);


                // //     // pool.query(
                // //     //     `INSERT INTO asset_images (image_id, asset_id, image_name) VALUES (?, ? , ?)`,
                // //     //     [
                // //     //          data.image_id,
                // //     //         results.insertId,
                // //     //         val

                // //     //     ],
                // //     // );

                // // }

                // return true;


                //     (error, result, fields) => {

                //         if (error) {
                //             return callback(error)
                //         }
                //         else {
                //            

                //         }

                //     }

                // }
                else {

                    return callback(null, results)
                }



            }


        )





    ),
    getassetsbycityapproved: (body, callback) => {
        pool.query(
            `SELECT * FROM asset WHERE asset.district_id = ? and isApproved IS NULL`,
            [body.district_id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    modifyAssetonApproved: (body, callback) => {
        pool.query(
            `Update asset set isApproved = ? where asset.id = ?`,
            [body.isApproved,body.id],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },

    updateAsset: (data, callback) => {
        pool.query(
            `UPDATE asset SET name = ?,size= ? ,capacity= ? ,present_use= ? ,yaer_of_est= ? ,rooms= ? ,labs= ? ,maintance= ? ,floors= ? ,owner= ? ,working_space= ? ,vaccant_space= ? ,parking= ? ,isApproved= NUll WHERE asset.id = ?`,[
                data.name,
                data.size,
                data.capacity,
                data.present_use,
                data.year_of_est,
                data.rooms,
                data.labs,
                data.maintance,
                data.floors,
                data.owner,
                data.working_space,
                data.vaccant_space,
                data.parking,
                data.id
            ],
            (error, results, fields) => {
                if (error) {
                    return callback(error)
                }
                else {
                    return callback(null, results)

                }

            }
        )
    },
    maintainance:(data, callback) => (
            pool.query(
                `insert into maintain (id,asset_id,requirement,budget,proposal,type)
                values(?,?,?,?,?,?)`,
                [
                    data.id,
                    data.asset_id,
                    data.requirement,
                    data.budget,
                    data.proposal,
                    data.type
             ],
                (error, results, fields) => {
                    if (error) {
                        return callback(error)
                    }
                    else {
                        return callback(null, results)
                    }
    
                }


            )
    ),

cityMaintainance:(data, callback) => (
    pool.query(
        `SELECT maintain.id , asset.name, asset_id, asset_id,requirement, budget, proposal, maintain.type, district_approval, state_approval FROM maintain JOIN asset ON asset.id = maintain.asset_id WHERE asset.sub_area_id= ? and district_approval IS NULL`,
        [
            data.sub_area_id,
           
     ],
        (error, results, fields) => {
            if (error) {
                return callback(error)
            }
            else {
                return callback(null, results)
            }

        }


    )
),

districtMApproved:(data, callback) => (
    pool.query(
       ` update maintain set district_approval = ? where maintain.id = ?`,
        [
          data.district_approval,data.id
           
     ],
        (error, results, fields) => {
            if (error) {
                return callback(error)
            }
            else {
                return callback(null, results)
            }

        }


    )
),










}



