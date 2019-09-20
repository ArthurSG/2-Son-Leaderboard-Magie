using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public static class Utils
{
    /// <summary>
    /// Remap a value
    /// </summary>
    /// <param name="value">Valeur à remap</param>
    /// <param name="fromLow">Valeur min de la range de départ</param>
    /// <param name="toLow">Valeur min de la range d'arrivée</param>
    /// <param name="fromHigh">Valeur max de la range de départ</param>
    /// <param name="toHigh">Valeur max de la range d'arrivée'</param>
    /// <returns></returns>
    public static float Remap(float value, float fromLow, float fromHigh, float toLow, float toHigh)
    {
        return toLow + (value - fromLow) * (toHigh - toLow) / (fromHigh - fromLow);
    }
}
