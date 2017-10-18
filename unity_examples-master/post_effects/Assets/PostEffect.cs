using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class PostEffect : MonoBehaviour {
  // see http://www.alanzucconi.com/2015/07/08/screen-shaders-and-postprocessing-effects-in-unity3d/

	public float blend_amount;
	private Material material;

	// Creates a private material used to the effect
	void Awake ()
	{
		material = new Material( Shader.Find("Hidden/PostEffect") );
	}
	
	// Postprocess the image
	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		material.SetFloat("_BlendAmount", blend_amount);
		Graphics.Blit (source, destination, material);
	}
}
