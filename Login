# login
Login Component by MaSoud ft 

import React, { useState,useEffect } from 'react'
import { Button,Badge } from 'react-bootstrap';
import { useNavigate } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import axios from 'axios';
import Swal from 'sweetalert2';
import { Alert } from '@mui/material';
const Login = () => {
    
    const navigate = useNavigate();

    const [tokenlogin,setTokenlogin]=useState("")
     const [error, setError] = useState("")
     const [txt, setTxt] = useState("")
     const token= JSON.parse( localStorage.getItem("token"))
    const cart = useSelector((state) => state.shopingcart)


     const [user, setUser] = useState({
      email: "",
      password: "",
      });

    const checkUser=async()=>{
  
 
        try {
          
          const {data}= await axios.post("http://kzico.runflare.run/user/login" , {
            
            email: user.email,
            password: user.password
        })
        console.log(data)
        setTokenlogin(data.user.token)
        setTxt(data.message)
        const token=localStorage.setItem("token",JSON.stringify(data.user.token))
    
        
      } catch (error) {
          setError(error.message)
          console.log("error"  +  error)
      }  
      }
      const emailvalidation = () =>{
        if(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(user.email)){
          console.log("Email correct")
          
        }else{
          Swal.fire({
            icon: 'error',
            title: 'Email Isn`t valid',
        })}}



    const PasswordValidiation = () => {
        if (/^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(user.password)) {

            console.log("password is valid")
        } else {
            console.log("password isn't valid")
            Swal.fire({
                icon: 'error',
                title: 'Password Isn`t valid',
            })
        }
    
        

    }
    return (
      <>
      
    
    
          <form onSubmit={(e) => e.preventDefault()}>
       
      
        <div className='login'>
             <Badge className='iii' style={{width:"370px",height:"50px",paddingTop:"15px",margin:"15px"
        ,fontSize:"20px"}}>Login</Badge>
                <p className='email'>Email:</p>
                <input  onChange={(e) => setUser({...user,email:e.target.value})}
                className='input' type="email" placeholder='enter youre email'></input>


                <p className='name'>Password:</p>
                <input onChange={(e) =>{ setUser({...user,password:e.target.value})}}
                 className='input'
                type="password" placeholder='enter youre password'></input>


                    
                <Button className='iii'  variant="primary" size="mb"
                    style={{ marginTop: "40px", marginLeft: "65px",width:"100px" }}
                    onClick={()=>{
                      if
                      (/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(user.email)
                      && /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(user.password)
                      ){
                        checkUser();
                        if(txt==="logged in")
                        navigate("/");   
                        setError(false) 
                        
                      }else{
                        PasswordValidiation();
                        emailvalidation();
                      }
                         }}>
                    Login
                </Button>
                <Button className='iii' variant="primary" size="mb"
                    style={{ marginTop: "40px", marginLeft: "60px",width:"100px" }}
                    onClick={() => navigate("/Signup")}>
                    Signup
                </Button>
                <div className="d-grid">
                {
                  error.length?
                  <Alert 
                  style={{width:"300px",marginLeft:"50px"}}
                  variant="outlined" severity="error">
                  {error}
                  (Check youre correct email or password)
                  </Alert>

                    :
                    ""
                }
                {
                  txt.length?
                  <Alert 
                  style={{width:"300px",marginLeft:"50px"}}
                  variant="outlined" severity="success">
                  {txt}
                  <Button  style={{marginLeft:"30px"}} onClick={()=>{
                    if(cart.length)
                    {navigate("/Card")}
                    else{
                      navigate("/")
                    }}}>Go Home</Button>
                  </Alert>
                  :
                 ""
                 
                }
              
                  
                </div>
              <p onClick={()=>navigate("/Setting/ChangePassword")} style={{marginLeft:"27px",paddingBottom:"20px"}} className="forgot-password text-right">
                Forgot <a>password?</a>
              </p>
           
        </div>
          </form>
           
            </>
        
    )
}

export { Login };
