<?php
	error_reporting(0);
	include_once("dbconnect.php");
	$search  = $_GET["search"];
	$results_per_page = 6;
	$pageno = (int)$_GET['pageno'];
	$page_first_result = ($pageno - 1) * $results_per_page;
	
	if ($search =="all"){
			$sqlloadhomestay = "SELECT * FROM tbl_homestay ORDER BY homestay_id DESC";
	}else{
		$sqlloadhomestay = "SELECT * FROM tbl_homestay WHERE homestay_name LIKE '%$search%' ORDER BY homestay_id DESC";
	}
	
	$result = $conn->query($sqlloadhomestay);
	$number_of_result = $result->num_rows;
	$number_of_page = ceil($number_of_result / $results_per_page);
	$sqlloadhomestay = $sqlloadhomestay . " LIMIT $page_first_result , $results_per_page";
	$result = $conn->query($sqlloadhomestay);
	
	if ($result->num_rows > 0) {
		$homestaysarray["homestay"] = array();
		while ($row = $result->fetch_assoc()) {
			$hslist = array();
			$hslist['homestay_id'] = $row['homestay_id'];
			$hslist['user_id'] = $row['user_id'];
			$hslist['homestay_name'] = $row['homestay_name'];
			$hslist['homestay_desc'] = $row['homestay_desc'];
			$hslist['homestay_price'] = $row['homestay_price'];
			
			$hslist['homestay_qty'] = $row['homestay_qty'];
			$hslist['homestay_state'] = $row['homestay_state'];
			$hslist['homestay_local'] = $row['homestay_local'];
			$hslist['homestay_lat'] = $row['homestay_lat'];
			$hslist['homestay_lat'] = $row['homestay_lat'];
			$hslist['homestay_date'] = $row['homestay_date'];
			array_push($homestaysarray["homestay"],$hslist);
		}
		$response = array('status' => 'success', 'numofpage'=>"$number_of_page",'numberofresult'=>"$number_of_result",'data' => $homestaysarray);
    sendJsonResponse($response);
		}else{
		$response = array('status' => 'failed','numofpage'=>"$number_of_page", 'numberofresult'=>"$number_of_result",'data' => null);
    sendJsonResponse($response);
	}
	
	function sendJsonResponse($sentArray)
	{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
	}