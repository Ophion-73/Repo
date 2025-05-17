using UnityEngine;

public class RotateDirLight : MonoBehaviour
{
    public float speedl;
    public float speed2;
    void Update()
    {
        transform.Rotate(speedl * Time.deltaTime, speed2 * Time.deltaTime, 0) ;
    }
}
