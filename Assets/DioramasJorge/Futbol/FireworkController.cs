using UnityEngine;

public class FireworkController : MonoBehaviour
{
    public ParticleSystem explosion;

    void Start()
    {
        // Lanzamiento inicial
        GetComponent<ParticleSystem>().Play();
        Invoke("Explode", 1.5f); // Tiempo de subida
    }

    void Explode()
    {
        explosion.transform.position = transform.position;
        explosion.Play();
        Destroy(gameObject, 2f); // Destruir después de explotar
    }
}
