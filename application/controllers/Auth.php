<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends CI_Controller {

	public function __construct(){
		parent::__construct();
		//Llama al modelo para buscar el usuario en BD
		$this->load->model("Usuarios_model");
	}
	public function index()
	{
		if ($this->session->userdata("login")) {
			redirect(base_url()."dashboard");
		}
		else{
			$this->load->view("admin/login");
		}
		

	}
//Aca se recibe los datos del formulario por post
	public function login(){
		$username = $this->input->post("username");
		$password = $this->input->post("password");
		$res = $this->Usuarios_model->login($username, sha1($password));
		//Password encriptado en sha1
		if (!$res) {
			$this->session->set_flashdata("error","El usuario y/o contraseña son incorrectos");
			//Si no esta el usuario se redirige a la vista login
			redirect(base_url());
		}
		else{
			//Si se encuentra usuario se crea variable de session tipo array con todos los datos del usuario
			$data  = array(
				'id' => $res->id, 
				'nombre' => $res->nombres,
				'rol' => $res->rol_id,
				'login' => TRUE
			);
			//Una vez asignado se redirecciona al controlador dashboard
			$this->session->set_userdata($data);
			redirect(base_url()."dashboard");
		}
	}

	public function logout(){
		$this->session->sess_destroy();
		redirect(base_url());
	}
}
