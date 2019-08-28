require 'rails_helper'

feature 'roadmap', type: :system, js: true do
  let(:post_status_1) { FactoryBot.create(:post_status) }
  let(:post_status_2) { FactoryBot.create(:post_status) }
  let(:post_status_3) { FactoryBot.create(:post_status, show_in_roadmap: false) }

  let(:board1) { FactoryBot.create(:board) }
  let(:board2) { FactoryBot.create(:board) }
  let(:board3) { FactoryBot.create(:board) }

  let(:post1) { FactoryBot.create(:post, post_status: post_status_1, board: board1) }
  let(:post2) { FactoryBot.create(:post, post_status: post_status_2, board: board2) }
  let(:post3) { FactoryBot.create(:post, post_status: post_status_3, board: board3) }

  # classes used in Roadmap component
  # gathered here so if one changes it has to be only changed here
  let(:roadmap_columns) { '.roadmapColumns' }
  let(:roadmap_column) { '.roadmapColumn' }
  let(:column_header) { '.columnHeader' }
  let(:post_link) { '.postLink' }


  before(:each) do
    # create post statuses and posts
    post_status_1
    post_status_2
    post_status_3
    board1
    board2
    board3
    post1
    post2
    post3
  end

  it 'has a title' do
    visit root_path

    expect(page).to have_content('Roadmap')
  end

  it 'shows a colum for each post status with show_in_roadmap set to true' do
    visit root_path

    within roadmap_columns do
      expect(page).to have_selector(roadmap_column, count: 2)
      expect(page).to have_selector(column_header, count: 2)
      expect(page).to have_content(post_status_1.name)
      expect(page).to have_content(post_status_2.name)
      expect(page).not_to have_content(post_status_3.name)
    end
  end

  it 'shows posts for each post status' do
    visit root_path

    within roadmap_columns do
      expect(page).to have_selector(post_link, count: 2)
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post2.title)
      expect(page).not_to have_content(post3.title)
    end
  end

  it 'shows board name for each post' do
    visit root_path

    within roadmap_columns do
      expect(page).to have_content(post1.board.name)
      expect(page).to have_content(post2.board.name)
      expect(page).not_to have_content(post3.board.name)
    end
  end
end