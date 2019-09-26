using UnityEngine;
using System.Collections;
using UnityEditor;

[CustomEditor(typeof(ExteriorCollidersGenerator))]
public class ExteriorCollidersGeneratorEditor : Editor
{
    public override void OnInspectorGUI()
    {
        DrawDefaultInspector();

        ExteriorCollidersGenerator myScript = (ExteriorCollidersGenerator)target;
        if (GUILayout.Button("Build Colliders"))
        {
            myScript.GenerateBorders();
        }
    }
}