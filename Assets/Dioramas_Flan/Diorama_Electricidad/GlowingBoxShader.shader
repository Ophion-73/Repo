Shader "Flan/GlowingBoxShader"
{
    Properties
    {
        _Color("Main Color", Color) = (1, 1, 0, 1) // Amarillo
        _GlowIntensity("Glow Intensity", Float) = 1.5
        _EdgeFade("Edge Fade", Float) = 3.0
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
                // Dirección hacia la cámara
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

                // Simula brillo en ángulos donde el normal mira a la cámara
                float glow = pow(saturate(dot(i.normal, viewDir)), _EdgeFade) * _GlowIntensity;

                // Combinamos color base con brillo blanco
                float3 baseColor = _Color.rgb;
                float3 finalColor = baseColor + glow;

                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
}
