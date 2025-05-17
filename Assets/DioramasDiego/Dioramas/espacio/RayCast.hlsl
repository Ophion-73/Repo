void Raycast_float(float3 RayOrigin, float3 RayDirection, float3 SphereOrigin, float SphereSize,
                   out float Hit, out float3 HitPosition, out float3 HitNormal)
{
    HitPosition = float3(0.0, 0.0, 0.0);
    HitNormal = float3(0.0, 0.0, 0.0);

    float t = 0.0f;
    float3 L = SphereOrigin - RayOrigin;
    float tca = dot(L, -RayDirection);

    if (tca < 0)
    {
        Hit = 0.0f;
        return;
    }

    float d2 = dot(L, L) - tca * tca;
    float radius2 = SphereSize * SphereSize;

    if (d2 > radius2)
    {
        Hit = 0.0f;
        return;
    }

    float thc = sqrt(radius2 - d2);
    t = tca - thc;

    Hit = 1.0f;
    HitPosition = RayOrigin - RayDirection * t;
    HitNormal = normalize(HitPosition - SphereOrigin);
}
void Raycast_float(float3 RayOrigin, float3 RayDirection, float3 SphereOrigin, float SphereSize,
                   out float Hit, out float3 HitPosition, out float3 HitNormal)
{
    HitPosition = float3(0.0, 0.0, 0.0);
    HitNormal = float3(0.0, 0.0, 0.0);

    float t = 0.0f;
    float3 L = SphereOrigin - RayOrigin;
    float tca = dot(L, -RayDirection);

    if (tca < 0)
    {
        Hit = 0.0f;
        return;
    }

    float d2 = dot(L, L) - tca * tca;
    float radius2 = SphereSize * SphereSize;

    if (d2 > radius2)
    {
        Hit = 0.0f;
        return;
    }

    float thc = sqrt(radius2 - d2);
    t = tca - thc;

    Hit = 1.0f;
    HitPosition = RayOrigin - RayDirection * t;
    HitNormal = normalize(HitPosition - SphereOrigin);
}
