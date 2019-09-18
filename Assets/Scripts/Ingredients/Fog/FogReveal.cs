using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FogReveal : MonoBehaviour
{

    public float revealSpeed = 1;
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Fog"))
            StartCoroutine(FadeFog(other.GetComponent<Renderer>().material));
    }

    private IEnumerator FadeFog(Material mat)
    {
        Color endCol = mat.color;
        endCol.a = 0;

        while (mat.color != endCol)
        {
            mat.color = Vector4.MoveTowards(mat.color, endCol, revealSpeed * Time.deltaTime);
            yield return null;
        }
    }
}
