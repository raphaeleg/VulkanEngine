#version 450

// Vertex Attributes
layout (location = 0) in vec3 position;
layout (location = 1) in vec3 color;
layout (location = 2) in vec3 normal;
layout (location = 3) in vec2 uv;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec3 fragPosWorld;
layout(location = 2) out vec3 fragNormalWorld;

struct PointLight {
	vec4 position;
	vec4 color;
};
layout(set = 0, binding = 0) uniform GlobalUbo {
	mat4 projectionMatrix;
	mat4 viewMatrix;
	mat4 inverseViewMatrix;
	vec4 ambientLightColor;
	PointLight pointLights[10];
	int numLights;
} ubo;


// only one push constant block per shader entry point
layout (push_constant) uniform Push {
	mat4 modelMatrix;
} push;	

void main() {
   vec4 positionWorld = push.modelMatrix * vec4(position, 1.0);
   gl_Position = ubo.projectionMatrix * ubo.viewMatrix * push.modelMatrix * vec4(position, 1.0f);

   fragNormalWorld = normalize((push.modelMatrix * vec4(normal, 0.0)).xyz);
   fragPosWorld = positionWorld.xyz;
   fragColor = color;
}