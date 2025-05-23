Shader "Unlit/Hielocos"
{
    Properties
    {
        _Color ("Color", Color) = (0.0, 0.7, 1.0, 0.5)
        _Speed ("Speed", Range(0, 10)) = 1.0
        _Intensity ("Intensity", Range(0, 1)) = 0.5
    }

    SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
        LOD 200
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 _Color;
            float _Speed;
            float _Intensity;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float offset = sin((i.worldPos.x + i.worldPos.z + _Time.y * _Speed) * 3.0) * _Intensity;
                float3 color = _Color.rgb + offset;
                return fixed4(color, _Color.a);
            }
            ENDCG
        }
    }

    FallBack "Transparent/Diffuse"
}
