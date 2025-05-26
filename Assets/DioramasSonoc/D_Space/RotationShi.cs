using UnityEngine;

public class RotationShi : MonoBehaviour
{
    public float rotationSpeed = 90f; // Grados por segundo

    void Update()
    {
        transform.Rotate(Vector3.up * rotationSpeed * Time.deltaTime);
    }
}
