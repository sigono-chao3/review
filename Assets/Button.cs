using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Button : MonoBehaviour {

	public void Review()
	{
		iOSReviewRequest.Request ();
	}

	public void Alert()
	{
		iOSReviewRequest.Alert ();
	}
}
