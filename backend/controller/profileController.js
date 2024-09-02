const Profile = require("../model/profileModel");

//GETS
exports.getProfile = async (req, res) => {
    try {
        const profile = await Profile.find();
        res.status(200).json(profile);
    } catch (error) {
        res.status(500).json({message: error.message});
    }
};

//CREATE
exports.createProfile = async (req, res) => {
    console.log(req.body);
    const{ firstName, lastName, course, year, enrolled} = req.body;

    console.log("========== Student Profile ==========");
    console.log("First Name:", firstName);
    console.log("Last Name:", lastName);
    console.log("Course:", course);
    console.log("Year:", year);
    console.log("Enrolled:", enrolled);

    try {
        const newProfile = new Profile({
            firstName,
            lastName,
            course,
            year,
            enrolled: enrolled === "true" || enrolled === true
        });
        await newProfile.save();
        res.status(201).json(newProfile);
    } catch (error) {
        res.status(400).json({message: error.message});
    }
};

//UPDATE
exports.updateProfile = async (req , res) => {
    const {id} = req.params;
    const { firstName, lastName, course, year, enrolled } = req.body;
    try {
        const updatedProfile = await Profile.findByIdUpdate(
            id,
            { firstName, lastName, course, year, enrolled },
            { new: true }
        );
        res.status(200).json(updatedProfile);
    } catch (error) {
        res.status(400).json({message : error.message});
    }
};

//DELETE
exports.deleteProfile = async (req, res) => {
    const {id} = req.params;
    try {
        await Profile.findByIdUpdate(id);
        res.status(204).end();
    } catch (error) {
        await Profile.findByIdUpdate(id);
        res.status(500).json({message : error.message});
    }
};