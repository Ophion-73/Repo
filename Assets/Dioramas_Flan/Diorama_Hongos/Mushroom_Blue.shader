
Shader "Custom/Mushroom_Blue"
{
    Properties
    {
        _Color("Mushroom Color", Color) = (0.2, 0.4, 1, 1)
        _HighlightColor("Highlight Color", Color) = (1, 1, 1, 1)
        _ShineStrength("Shine Strength", Float) = 1.2
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

            float4 _Color;
            float4 _HighlightColor;
            float _ShineStrength;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                float intensity = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), 2.0);
                float3 finalColor = _Color.rgb + _HighlightColor.rgb * intensity * _ShineStrength;
                return float4(finalColor, 1.0);
            }
            ENDCG
        }
    }
}
