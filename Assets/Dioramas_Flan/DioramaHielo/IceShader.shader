
Shader "Custom/IceShader"
{
    Properties
    {
        _IceColor("Ice Color", Color) = (0.6, 0.9, 1.0, 1) // Azul hielo
        _FresnelColor("Fresnel Highlight", Color) = (1, 1, 1, 1)
        _FresnelPower("Fresnel Power", Float) = 5.0
        _FresnelStrength("Fresnel Strength", Float) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 250
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _IceColor;
            float4 _FresnelColor;
            float _FresnelPower;
            float _FresnelStrength;

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
                float fresnel = pow(1.0 - saturate(dot(viewDir, normalize(i.worldNormal))), _FresnelPower);
                float3 fresnelEffect = _FresnelColor.rgb * fresnel * _FresnelStrength;

                float3 finalColor = _IceColor.rgb + fresnelEffect;
                return float4(finalColor, 0.75); // semi-transparente
            }
            ENDCG
        }
    }
}
