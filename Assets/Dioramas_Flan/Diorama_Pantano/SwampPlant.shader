
Shader "Custom/SwampPlant"
{
    Properties
    {
        _PlantColor("Plant Color", Color) = (0.3, 0.7, 0.2, 1)
        _HighlightColor("Highlight", Color) = (0.6, 1, 0.5, 1)
        _HighlightStrength("Highlight Strength", Float) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _PlantColor;
            float4 _HighlightColor;
            float _HighlightStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 worldNormal : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float fresnel = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), 3.0);
                float3 color = _PlantColor.rgb + _HighlightColor.rgb * fresnel * _HighlightStrength;
                return float4(color, 1.0);
            }
            ENDCG
        }
    }
}
