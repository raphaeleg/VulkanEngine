#pragma once
#include "lve_game_object.hpp"
#include "lve_camera.hpp"
#include "lve_pipeline.hpp"
#include <memory>
#include <vector>

namespace lve {
	class SimpleRenderSystem {
	public:
		SimpleRenderSystem(LveDevice &device, VkRenderPass renderPass);
		~SimpleRenderSystem();
		SimpleRenderSystem(const SimpleRenderSystem&) = delete;
		SimpleRenderSystem& operator=(const SimpleRenderSystem&) = delete;

		void RenderGameObjects(
			VkCommandBuffer commandBuffer,
			std::vector<LveGameObject> &gameObjects,
			const LveCamera camera
		);

	private:
		LveDevice &lveDevice ;
		std::unique_ptr<LvePipeline> lvePipeline;
		VkPipelineLayout pipelineLayout;
		
		void CreatePipelineLayout();
		void CreatePipeline(VkRenderPass renderPass);
	};
}	// namespace lve