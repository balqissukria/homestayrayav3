<?php
	error_reporting(0);
	if (!isset($_GET['userid'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
	}
	$userid = $_GET['userid'];
	include_once("dbconnect.php");
	$sqlloadhomestay = "SELECT * FROM tbl_homestay WHERE user_id = '$userid'";
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
			array_push($homestaysarray["homestay"],$prlist);
		}
		$response = array('status' => 'success', 'data' => $homestaysarray);
    sendJsonResponse($response);
		}else{
		$response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
	}
	
	function sendJsonResponse($sentArray)
	{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
	}