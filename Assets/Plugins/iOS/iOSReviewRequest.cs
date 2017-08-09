using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if (UNITY_IOS && !UNITY_EDITOR)
using System.Runtime.InteropServices;
#endif

public class iOSReviewRequest : MonoBehaviour 
{
	
	#if (UNITY_IOS && !UNITY_EDITOR)
    [DllImport ("__Internal")]
    private static extern void requestReview();

	[DllImport ("__Internal")]
	private static extern bool isSKStoreReviewControllerAvailable();

	[DllImport ("__Internal")]
	private static extern void showAlert(string title, string message, string cancelText, string okText);

	[DllImport ("__Internal")]
	private static extern int getLastAlertResult();
	#endif
	
	public static void Request()
	{
		#if (UNITY_IOS && !UNITY_EDITOR)
		Debug.Log("Trying to request the review window.");
		Debug.Log("Available " + isSKStoreReviewControllerAvailable());
	    requestReview();
		#endif
	}

	public static void Alert()
	{
		#if (UNITY_IOS && !UNITY_EDITOR)
		showAlert("Alert title", "rate us?", "nah", "sure");
		Debug.Log(getLastAlertResult());
		#endif
	}
}
