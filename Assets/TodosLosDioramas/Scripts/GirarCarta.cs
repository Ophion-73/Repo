using UnityEngine;

public class GirarCarta : MonoBehaviour
{
    public float velocidadGiro;

    void Update()
    {
        transform.Rotate(-1 * Vector3.forward *  velocidadGiro * Time.deltaTime);
    }
}
