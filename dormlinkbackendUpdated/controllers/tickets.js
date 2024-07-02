
// import ticketModel  from "../models/ticketModel.js";
const ticketModel = require('../models/Tickets.js')



exports.createTicketController = async (req, res) => {
    try {
        console.log(req.body)
        const {name,title,description,roomNo,category} = req.body;
        const {enrollmentNo} =req.body;
        //validation
        
        if (!name)
            return res.status(500).send({error:"Name is required"});
        if (!category)
            return res.status(500).send({error:"Category is required"});
        if (!title)
            return res.status(500).send({error:"Title is required"});
        if( !description)
            return res.status(500).send({error:"Description is required"});
        if (!roomNo)
            return res.status(500).send({error:"Room No is required"});    
      
        const newTicket = new ticketModel({
            enrollmentNo,
            name,
            title,
            description,
            category,
            roomNo
        });
        
        await newTicket.save();
    
      
        
        
        res.status(201).send({
            success:true,
            message:'Ticket Created',
            newTicket
        })
       
    }
    catch (error) {
        console.log(error);
        res.status(500).send({
            success: false,
            error,
            message: "Error in Ticket Creation"
        });
    }

};


exports.getOpenTicketController=async (req,res)=>{
    const {isAdmin,enrollmentNo} =req.body;
    if(isAdmin){
        try {
            const orderA= await ticketModel.find({status:0}).limit(15);
            
            res.status(200).json(
                orderA
            );
        } catch (error) {
            console.log(error);
            res.send(500).send({
                success:false,
                message:'Error in getting Orders',
                error:error.message
            })
        }
    }else{
        try {
            const orderA= await ticketModel.find({status:0 ,enrollmentNo}).limit(15);
            
            res.status(200).json(
                orderA
            );
        } catch (error) {
            console.log(error);
            res.send(500).send({
                success:false,
                message:'Error in getting Orders',
                error:error.message
            })
        }
    }
    
};


exports.getClosedTicketController=async (req,res)=>{
    const {isAdmin,enrollmentNo} =req.body;
    if(isAdmin){
        try {
            const orderA= await ticketModel.find({status:1}).limit(15);
            
            res.status(200).json(
                orderA
            );
        } catch (error) {
            console.log(error);
            res.send(500).send({
                success:false,
                message:'Error in getting Orders',
                error:error.message
            })
        }
    }else{
        try {
            const orderA= await ticketModel.find({status:1 ,enrollmentNo}).limit(15);
            
            res.status(200).json(
                orderA
            );
        } catch (error) {
            console.log(error);
            res.send(500).send({
                success:false,
                message:'Error in getting Orders',
                error:error.message
            })
        }
    }
    // try {
    //     // const oid=req.params.oid;
        
    //     const orderA= await ticketModel.find({status:1}).limit(15);
        
    //     res.status(200).send({
    //         success:true,  
    //         message:"All CLosed Tickets",
    //         orderA
    //     });
    // } catch (error) {
    //     console.log(error);
    //     res.send(500).send({
    //         success:false,
    //         message:'Error in getting Orders',
    //         error:error.message
    //     })
    // }
};

// export const getOneOrderController=async (req,res)=>{
//     try {
//         const {oid,uid}=req.params;
//         const orderA= await orderModel.findById(oid).populate('deliverAdd');
        
//         res.status(200).send({
//             success:true,  
//             message:"Returned Order",
//             orderA
//         });
//     } catch (error) {
//         console.log(error);
//         res.send(500).send({
//             success:false,
//             message:'Error in getting orders',
//             error:error.message
//         })
//     }
// };


exports.deleteTicketController= async (req,res)=>{
    try {
        const ticketV=await ticketModel.findByIdAndDelete(req.params.pid);
        res.status(200).send({
            success:true,
            message:"Successfully Deleted"
        })
    } catch (error) {
        console.log(error);
        res.status(500).send({
            success:false,
            message:"Error in Delete",
            error
        })
    }
};


exports.updateTicketController=async(req,res)=>{
    try {
        const {title,description,roomNo,category} = req.body;
        const id=req.params.pid;
        
        
        //validation

    if (!title)
        return res.status(500).send({error:"Title is required"});
    if( !description)
        return res.status(500).send({error:"Description is required"});
    if (!roomNo)
        return res.status(500).send({error:"Room No is required"});    
    if (!category)
        return res.status(500).send({error:"Category is required"});
        
        //const existingProduct = await new productModel.findOne({ name });

        // if (existingProduct) {
        //     return res.status(200).send({
        //         success: true,
        //         message: "Category Already Exists"
        //     })
        // }
        const newTicket = await ticketModel.findByIdAndUpdate(id,{
            title,description,roomNo,category
        },{new:true});
        
        await newTicket.save();
        res.status(201).send({
            success:true,
            message:'Ticket Updated',
            newTicket
        })
    }
    catch (error) {
        console.log(error);
        res.status(500).send({
            success: false,
            error,
            message: "Error in Updation"
        });
    }

};
exports.updateTicketStatusController=async(req,res)=>{
    try {
        const {status} = req.body;
        const {id}=req.params;
        
        
        
        //const existingProduct = await new productModel.findOne({ name });

        // if (existingProduct) {
        //     return res.status(200).send({
        //         success: true,
        //         message: "Category Already Exists"
        //     })
        // }
        const newTicket = await ticketModel.findByIdAndUpdate(id,{
            status
        });
        
        await newTicket.save();
        res.status(201).send({
            success:true,
            message:'status Updated',
            newTicket
        })
    }
    catch (error) {
        console.log(error);
        res.status(500).send({
            success: false,
            error,
            message: "Error in Status Updation"
        });
    }

};