using UnityEngine;

public class RotationTurnign : MonoBehaviour
{
    public float rotationSpeed = 90f; // Grados por segundo

    void Update()
    {
        transform.Rotate(Vector3.forward * rotationSpeed * Time.deltaTime);
    }
}
