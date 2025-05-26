
Shader "Custom/ElectricBoxShader"
{
    Properties
    {
        _Color("Electric Color", Color) = (0.2, 0.6, 1, 1) // Azul eléctrico
        _GlowIntensity("Glow Intensity", Float) = 2.0
        _EdgeFade("Edge Fade", Float) = 6.0
        _FlickerSpeed("Flicker Speed", Float) = 20.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _Color;
            float _GlowIntensity;
            float _EdgeFade;
            float _FlickerSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 normal : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float intensity = pow(saturate(dot(i.normal, viewDir)), _EdgeFade);

                // Simula parpadeo eléctrico con ruido temporal
                float flicker = sin(_Time.y * _FlickerSpeed + i.worldPos.x * 5.0) * 0.5 + 0.5;
                float glow = intensity * _GlowIntensity * flicker;

                float3 finalColor = _Color.rgb * glow;
                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
}
